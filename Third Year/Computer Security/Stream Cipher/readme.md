# Purpose
The purpose of this assignment is that you will design a practical encryption application
around a symmetric encryption algorithm. So you will write programs for key generation,
data encryption, and data decryption that use the encryption algorithm.
The assignment is to implement a stream cipher. A stream cipher encrypts an arbitrary
length of plaintext. It is described in Section 6.5.2 in Goodrich-Tamassia and the lecture
notes of Symmetric Encryption I.

## Background
Stream Ciphers
Stream Ciphers can be divided into synchronous and self-synchronizing encryption systems.
Synchronous stream ciphers need a key (or seed) for the random number generator. If parts of
the stream are lost, then the communication needs to restart to decrypt the message stream.
A self-synchronizing stream cipher needs the previous n symbols to restart the decryption
process.
Pseudo-random Number Generators
A simple PRNG (PseudoRandom Number Generator) is the linear congruential generator. It
generates uniform random numbers by using modulo arithmetic and a recursive calculation:
Xi+1 = aXi + b mod m

We want the period, i.e., the length of the pseudo-random sequence before it repeats itself, to
be as large as possible. The period is given by ϕ(m), This means that the period is
maximized if m is a prime, which gives the period ϕ(m) = m − 1. To get the maximum
period, a has to be a primitive root of m, that is, the multiplicative order of a should be
ord$(a) = ϕ(m). This will result in a pseudo-random sequence in the interval [1, m-1],
where all numbers are represented. Notice that 0 is not in the sequence and should not be
given as a seed to x0. The offset b does not change the statistical properties.

### Statistical tests of randomness
The simplest method is to generate a bitmap (0 or 1 pixels) of say 300 x 300 and plot these as
a bitmap. See example at https://www.random.org/analysis/ . The human brain is very good
at discovering patterns.
Other methods are the Chi-square test (https://www.khanacademy.org/math/ap-statistics/chisquare-tests/chi-square-goodness-fit/v/chi-square-statistic) or run-test. As the mathematical
statistics course is in the third year, you are not required to use these tests in the assignment.
RC4 ciphers
https://en.wikipedia.org/wiki/RC4

## Implementation
In this assignment, a Stream Cipher implementation consists of a program:
1. StreamCipher is a program that takes a plaintext message of a sequence of bytes
and an encryption key as input. The output is a ciphertext consisting of a sequence of
bytes.
StreamCipher takes three arguments and should be executed as follows:
$ javac StreamCipher.java
$ java StreamCipher <key> <infile> <outfile>
The first argument is the encryption key. StreamCipher will read the input from the file with
the name given as the second argument <infile>, and write the resulting output to a file
named <outfile>. All data files have the same format: binary files, i.e., a file consists of a
sequence of bytes.

### Task 1. Simple Synchronous Stream Cipher
The first task is to write the StreamCipher program that generates a pseudo-random stream of
bytes and combines it with an input that consists of plaintext (for encryption) or of ciphertext
(for decryption). In the first case, the output will be the ciphertext, and in the second case, the
plaintext. You should use the standard PRNG in the programming language library
(java.util.Random), and use <key> as the seed for the random number generator.
Use the standard PRNG to generate a stream of bytes, and compute the output as the bytewise exclusive-or (XOR) of the input and the bytes from the PRNG, see the example in the
lecture Symmetric Key Encryption I. To generate a random byte, use the Random.NextInt(int
bound) method with the “bound” parameter set to 256.


### Reading Input Data
Since you are dealing only with binary data in this assignment, you can use basic I/O streams
in Java for reading and writing bytes. For example, you might find the different read/write
methods of FileInputStream/FileOutputStream or
BufferedInputStream/BufferedOutputStream to be suitable.

### Error Handling
If the user gives incorrect parameters or the input data does not match the parameters, this
should be detected, and an informative error message should be generated. (Java exceptions
do not count as informative error messages.)
Moreover, your program should follow the standard convention that a program terminates
(“exits”) with status 0 if the execution of the program was unsuccessful, otherwise the status
is non-zero. Anything that prevents the program from completing its task is considered an
error. In particular, invalid user input is an error, and should result in the program exiting
with non-zero status.
The exit status is assigned with the exit() system call. See the exit(int) method in
java.lang.System.

