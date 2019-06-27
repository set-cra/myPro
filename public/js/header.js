function change(){
    let head=document.getElementsByClassName("double")[0];
    console.log(head.clientHeight);
    if(head.clientHeight==74){
        head.className="only";
    }else{
        head.className="double";
    }
}