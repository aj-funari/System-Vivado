import math

# Adapted from:  
# https://www.geeksforgeeks.org/mid-point-circle-drawing-algorithm/

# This is identical to that of SlowCircleDrawer
# So you can accelerate it!


class MyCircleDrawer:
    def __init__(self):
       pass

    def computeTheta(self, x,y, x_centre, y_centre):
        return math.atan2(x-x_centre, y-y_centre)
    
    def sortedInsert(self, theList, x, y, x_centre, y_centre):
        newTheta = self.computeTheta(x, y, x_centre, y_centre)
        for index, value in enumerate(theList):
            oldTheta = self.computeTheta(value[0], value[1], x_centre, y_centre)
            if oldTheta > newTheta:
                theList.insert(index, (x,y))
                return theList
        theList.append((x,y))
        return theList

    def midPointCircleDraw(self,x_centre, y_centre, r): 

        x = r 
        y = 0
        list0 = []
        list1 = []
        list2 = []
        list3 = []
        list4 = []
        list5 = []
        list6 = []
        list7 = []
        final = []

        # Printing the initial point the  
        # axes after translation  
        points = self.sortedInsert( list0, 
                                    x + x_centre, y + y_centre,
                                    x_centre, y_centre)

        # When radius is zero only a single  
        # point be printed  
        if (r > 0) : 

            points = self.sortedInsert( list1, # points
                                    -x + x_centre, -y + y_centre,
                                    x_centre, y_centre) 

            points = self.sortedInsert( list2, # points
                                    y + x_centre,  x + y_centre, 
                                    x_centre, y_centre)

            points = self.sortedInsert( list7, # self.list3 # points
                                    -y + x_centre, -x + y_centre,
                                    x_centre, y_centre)

        # Initialising the value of P  
        P = 1 - r  

        while x > y:

            y += 1 

            # Mid-point inside or on the perimeter 
            if P <= 0:  
                P = P + 2 * y + 1

            # Mid-point outside the perimeter  
            else:          
                x -= 1
                P = P + 2 * y - 2 * x + 1

            # All the perimeter points have  
            # already been printed  
            if (x < y): 
                break

            # Printing the generated point its reflection  
            # in the other octants after translation  
            points = self.sortedInsert( list0, # points
                                      x + x_centre, y + y_centre,
                                      x_centre, y_centre)

            # print("List0 = ", list0)

            points = self.sortedInsert( list4, #points 
                                      -x + x_centre, y + y_centre,
                                      x_centre, y_centre)

            # print("List4 = ", list4)

            points = self.sortedInsert( list5, #points 
                                      x + x_centre, -y + y_centre,
                                      x_centre, y_centre)

            # print("List5 = ", list5)

            points = self.sortedInsert( list1, # points
                                      -x + x_centre, -y + y_centre, 
                                      x_centre, y_centre)

            # print("List1 = ", list1)

            # If the generated point on the line x = y then  
            # the perimeter points have already been printed  
            if x != y: 

                points = self.sortedInsert( list2, # points 
                                          y + x_centre, x + y_centre,
                                          x_centre, y_centre)

                # print("List2 = ", list2)

                points = self.sortedInsert( list6, # points
                                          -y + x_centre, x + y_centre,
                                          x_centre, y_centre)

                # print("List6 = ", list6)

                points = self.sortedInsert( list7, #points 
                                          y + x_centre, -x + y_centre,
                                          x_centre, y_centre)
                
                # print("List7 = ", list7)

                points = self.sortedInsert( list3, #  points
                                          -y + x_centre, -x + y_centre, 
                                          x_centre, y_centre)

                # print("List3 = ", list3)

        #repeat the first point to make the circle complete
        # points.append(points[0])
        list7.append(list3[0])

        final = list3 + list1 + list4 + list6 + list2 + list0 + list5 + list7
        # print(final)

        return final

    def draw_circles(self, inputs):
        circles = []
        for x,y,r in inputs:
            circle = self.midPointCircleDraw(x,y,r)
            circles.append( circle )
        return circles

if __name__ == "__main__":

    C = MyCircleDrawer()

    rand_inputs = [(3, 3, 2), (3, 3, 2)]
    circles = C.draw_circles(rand_inputs)
    