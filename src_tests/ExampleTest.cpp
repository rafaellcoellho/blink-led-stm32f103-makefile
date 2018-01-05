#include <CppUTest/TestHarness.h>

extern "C"
{
#include "../inc/helloWorld.h"
}

TEST_GROUP(helloWorld)
{
        void setup()
        {
        }

        void teardown()
        {
        }
};

TEST(helloWorld, test1)
{
    STRCMP_EQUAL("Koe!", helloWorld());
}
