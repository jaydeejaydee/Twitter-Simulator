
ClickX(clickThis)
{
  Send, ^f
  Sleep, 300
  Send, %clickThis%
  Sleep, 300
  Send, ^{Return}
  Sleep, 3000
}

RandomClickX(clickThis)
{
  Send, ^f
  Sleep, 5000
  Send, %clickThis%
  Sleep, 1000
  Random, rn, 1, 200
  Loop, %rn%
  {
    Send, {Return}
  }
  Send, ^{Return}
  Sleep, 3000
}

RandomChoice(options)
{
  Random, rn, 1, options.Length()
  Random, seeder, 1, 9999999
  Random, , seeder - 243
  return options[rn]
}

ScrollDown()
{
  Random, rn, 140,800
  x := rn//10
  Loop, %rn%
  {
    MouseClick,WheelDown,,,100,10,,R
    Sleep, 100
    if(Mod(A_Index,x)=0)
    {
  	Loop, %x%
  	{
  	  MouseClick,WheelUp,,,100,10,,R
  	}
    }
  }


}


TwitterSession()
{
  options := ["home","home","home","home","home","home","home","home","home","notifications","profile"]

  Random, start, 3, 10
  Random, stop, 25, 50
  Random, rn, start, stop
  Loop, %rn%
  {
    if(Mod(A_Index,2)!=0)
	{
	  Send, ^w
	}
    Sleep, 500
    Run, https://twitter.com
    Sleep, 3000
    choice := RandomChoice(options)
  
    if(choice="notifications")
    {
	  ScrollDown()
      ClickX("notifications")
	  subChoice := RandomChoice(["mentions","@","@","@","@"])
	  if(subChoice="@")
	  {
	    RandomClickX(subChoice)
	  }
	  else
	  {
	    ClickX(subChoice)
	  }
    }
    
    if(choice="profile")
    {
      ClickX("profile")
	  subChoice := RandomChoice(["followers","following","replies","likes"])
	  ClickX(subChoice)
    }
    
    if(choice="home")
    {
	  ScrollDown()
      subChoice := RandomChoice(["tweet","profile"])
      if(subChoice="tweet")
      {
        RandomClickX("Show this thread")
        subSubChoice := RandomChoice(["likes","retweets"])
		ClickX(subSubChoice)
      }
    
      else
      {
	    ScrollDown()
        RandomClickX("@")
        subSubChoice := RandomChoice(["followers"," following","replies","likes"])
        ClickX(subSubChoice)
      }
    }
    
  }

}

TwitterSession()

Esc::ExitApp
