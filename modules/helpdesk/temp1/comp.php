<?php
$id = $_POST['id'];
// Connects to your Database 
if($id!='0'){
    mysql_connect("localhost", "root", "kontron") or die(mysql_error()); 
    mysql_select_db("dotproject") or die(mysql_error()); 
    $data = mysql_query("SELECT company_application FROM companies WHERE company_id=".$id."")
    or die(mysql_error()); 
    while($info = mysql_fetch_array($data)) 
    { 
        $result[]=$info['company_application'];
    }
    if($result[0]!=""){
        $string = $result[0];
        $findme   = 'Access unlimited';
        $pos = strpos($string, $findme);        
        if($pos !== false){
            $data1 = mysql_query("SELECT application_date FROM companies WHERE company_id=".$id."")
            or die(mysql_error()); 
            while($info1 = mysql_fetch_array($data1)) 
            { 
                $date=$info1['application_date'];
            }
            
            $dqs=mysql_query("select dept_batching_maintenance,dept_name from departments
            INNER JOIN  companies  ON departments.dept_company = companies .company_id
            where  companies.company_id='".$id."' and dept_batching_maintenance!='' ")
            or die(mysql_error());
            $rows=mysql_num_rows($dqs);
            if($rows !== false){
                $today = date("m/d/Y");
                //$today_time = strtotime($today);
               echo '<table border="1" ><tr>
                    <th style="background:none;border:none;color:#000;">System</th>
                    <th style="background:none;border:none;color:#000;">Maintenance End Date</th>
                </tr>';
               if($date!=""){
                    //$date_time = strtotime($date);
                    if(strtotime($today) <= strtotime($date)){
                        echo '<tr style="color:green;"><td>Access Unlimited</td><td>'.$date.'</td></tr>';
                    }else{
                        echo '<tr style="color:red;"><td>Access Unlimited</td><td>'.$date.'</td></tr>';
                    }
               }
                while($fetch = mysql_fetch_array($dqs)){
                    $newdates=date("m/d/Y", strtotime($fetch['dept_batching_maintenance']));                    
                    //$newdates_time = strtotime($newdates);
                    if(strtotime($today) <= strtotime($newdates)){ 
                        echo '<tr style="color:green;"><td>'.$fetch['dept_name'].'</td>';
                        echo '<td>'.$newdates.'</td></tr>';
                    }else{
                        echo '<tr style="color:red;"><td>'.$fetch['dept_name'].'</td>';
                        echo '<td>'.$newdates.'</td></tr>';
                    }
                }
               echo '</table>';
            }
        }        
        $array1=implode($result,",");
        $result = explode(',',$array1);
        echo '@';
        echo '<select id="pai" name="item_application" class="text" size="1">';
        echo '<option value="Not Applicable">Not Applicable</option>';
        foreach($result as $rs){
            echo '<option value=';
            echo '"'.$rs.'"'.'>'.$rs.'</option>';
        }
        echo '</select>';
    }else{
        echo "null";
    }
}else{
    echo "Please select company";
}
?>