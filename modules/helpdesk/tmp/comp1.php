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
        $array1=implode($result,",");
        $result = explode(',',$array1);
        $res1= '<select id="pai" name="item_application" class="text" size="1">';
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