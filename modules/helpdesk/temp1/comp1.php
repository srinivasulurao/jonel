<?php
$id = $_POST['id'];
$item_id = $_POST['item_id'];
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
               $res1= '<table border="1" ><tr>
                    <th style="background:none;border:none;color:#000;">System</th>
                    <th style="background:none;border:none;color:#000;">Maintenance End Date</th>
                </tr>';
               if($date!=""){
                    //$date_time = strtotime($date);
                    if(strtotime($today) <= strtotime($date)){
                        $res1.= '<tr style="color:green;"><td>Access Unlimited</td><td>'.$date.'</td></tr>';
                    }else{
                        $res1.= '<tr style="color:red;"><td>Access Unlimited</td><td>'.$date.'</td></tr>';
                    }
               }
                while($fetch = mysql_fetch_array($dqs)){
                    $newdates=date("m/d/Y", strtotime($fetch['dept_batching_maintenance']));                    
                    //$newdates_time = strtotime($newdates);
                    if(strtotime($today) <= strtotime($newdates)){ 
                        $res1.= '<tr style="color:green;"><td>'.$fetch['dept_name'].'</td>';
                        $res1.= '<td>'.$newdates.'</td></tr>';
                    }else{
                        $res1.= '<tr style="color:red;"><td>'.$fetch['dept_name'].'</td>';
                        $res1.= '<td>'.$newdates.'</td></tr>';
                    }
                }
               $res1.= '</table>';
            }           
            
        }
        
        $array1=implode($result,",");
        $result = explode(',',$array1);
        $res1.= '@';
        $res1.= '<select id="pai" name="item_application" class="text" size="1">';
        $res1.= '<option value="Not Applicable">Not Applicable</option>';
        foreach($result as $rs){
            $res1.= '<option value=';
            $res1.= '"'.$rs.'"'.'>'.$rs.'</option>';
        }
        $res1.= '</select>';
        $data1=mysql_query("SELECT  item_application FROM  helpdesk_items WHERE item_company_id=".$id." and item_id=".$item_id."")
        or die(mysql_error()); 
        while($info1 = mysql_fetch_array($data1)) 
        { 
            $result1=$info1['item_application'];
        }
        echo $res1.','.$result1;
    }else{
        echo "null";
    }
}else{
    echo "Please select company";
}
?>