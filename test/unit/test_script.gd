extends GutTest
func before_each():
	gut.p("ran setup", 2)
	
func test_assert_eq_number_not_equal():
	assert_eq(1, 2, "Should fail.  1 != 2")
