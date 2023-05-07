--config here
width = 5
length = 5
height = 5
makeDoor = false --makes 1x2 doorway before digging
digUp = true --change to false so turtle digs down
--do not change below this line

turnLeftOrRight = true

--list of blocks to ignore digging
nonsolid_blocks = {
  ["minecraft:lava"] = true,
  ["minecraft:water"] = true
}

--functions
--detects if block is diggable and ignores blocks in nonsolid_blocks table
function is_solid_block_in_front_of_turtle()
    local has_block, block = turtle.inspect()
    return has_block and not nonsolid_blocks[block.name]
end

function dig()
  while is_solid_block_in_front_of_turtle() do
    turtle.dig()
  end
end

--initialization;
--creates 1x2 doorway then digs and moves to starting corner
--makes doorway
if makeDoor then
  dig()
  turtle.forward()
  turtle.digUp()
  dig()
  turtle.forward()

  --moves to starting position
  turtle.turnLeft()
  for i=0, math.floor(width / 2) - 1 do
    turtle.dig()
    turtle.forward()
  end
turtle.turnRight()
end

--starts digging room
for i=1, height do
  for j=1, width do
    for k=1,length - 1 do
      dig()
      turtle.forward()
    end

    --logic to turn turtle correctly
    if j < width then
      if turnLeftOrRight then
        turtle.turnRight()
        dig()
        turtle.forward()
        turtle.turnRight()
        turnLeftOrRight = false
      else
        turtle.turnLeft()
        dig()
        turtle.forward()
        turtle.turnLeft()
        turnLeftOrRight = true
      end
    end
  end

  --logic for digging up or down
  --first moves to starting corner
  if width > 1 then
    if turnLeftOrRight then
      turtle.turnLeft()
      for n=1, width - 1 do
        turtle.forward()
      end
      turtle.turnRight()
      for m=1, length - 1 do
        turtle.back()
      end
    else
      turtle.turnRight()
      for n=1, width - 1 do
        turtle.forward()
      end
      turtle.turnRight()
      turnLeftOrRight = true --resets boolean
    end
  else
    for n=1,length - 1 do
      turtle.back()
    end
  end
  --check to see if we need
  --to dig up or down
  if i < height then
    if digUp then
      turtle.digUp()
      turtle.up()
    else
      turtle.digDown()
      turtle.down()
    end
  end
end

--moves turtle back to starting corner at initial height
for i=1, height - 1 do
  if digUp then
    turtle.down()
  else
    turtle.up()
  end
end