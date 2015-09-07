<?php
$id = $_POST['id'];
// Connects to your Database 
if($id!='0'){
    mysql_connect("localhost", "root", "kontron") or die(mysql_error()); 
    mysql_select_db("dptest") or die(mysql_error()); 
    $data = mysql_query("SELECT company_application FROM companies WHERE company_id=".$id."")
    or die(mysql_error()); 
    while($info = mysql_fetch_array($data)) 
    { 
        $result[]=$info['company_application'];
    }
    if($result[0]!=""){
        $array1=implode($result,",");
        $result = explode(',',$array1);
        echo '<select id="iap" name="item_application" class="text" size="1">';
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