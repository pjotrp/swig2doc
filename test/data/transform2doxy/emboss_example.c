/******************************************************************************
** @source AJAX translation functions
**
** @@
**
** This file is used as an test file for tranforming EMBOSS style
** layout of 'C' code to something that can be digested with Doxygen.
**
** Note: this is not valid code.
**
** These functions control all aspects of sequence translation
**
** These functions do not translate to the 'ambiguity' residues
** 'B' (Asn or Asp) and 'Z' (Glu or Gln). So the codons:
** RAC, RAT, RAY, RAU which could code for 'B' return 'X'
** and SAA, SAG, SAR which could code for 'Z' return 'X'.
**
** This translation table doesn't have the doubly ambiguous
** codons set up:
** YTR - L
** MGR - R
** YUR - L
**
** This should be attended to at some time.
**
** @author Copyright (C) 1999 Unknown
** @version 2.0
** @modified 15/05/2010 Transform2Doxy example
** @@
**
******************************************************************************/

#include <stddef.h>
#include <stdarg.h>
#include <float.h>
#include <limits.h>

#include "ajax.h"

static AjPTable trnCodes = NULL;


/* table to convert character of base to translation array element value */
static ajint trnconv[] =
{
    /* characters less than 64 */
    14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14,
    14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14,

  /*' '  !   "   #   $   %   &   '   (   )   *   +   ,   -   .   / */
    14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14

};


/*
 ** table to convert character of COMPLEMENT of base to translation array
 ** element value
 */

static ajint trncomp[] =
{
    /* characters less than 64 */
    14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14,
    14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14,
  /* p   q   r   s   t   u   v   w   x   y   z   {   |   }   ~   del */
    14, 14,  8,  7,  0,  0, 13,  6, 14,  5, 14, 14, 14, 14, 14, 14
};


static AjPStr trnResidueStr = NULL;

static void trnNoComment(AjPStr* text);

static AjBool trnComplete(AjPTrn thys);




/* @func ajTrnDel *************************************************************
**
** Deletes a translation table object
**
** @param pthis [AjPTrn*] Address of translation table object
** @return [void]
** @category delete [AjPTrn] Default destructor
** @@
******************************************************************************/

void ajTrnDel(AjPTrn* pthis)
{
    AjPTrn thys;

    if(!pthis)
        return;

    return;
}




/* @func ajTrnNewC ************************************************************
**
** Initialises translation. Reads a translation data file.
**
** @param [r] filename [const char*] translation table file name
** @return [AjPTrn] Translation object
** @category new [AjPTrn] Default constructor
** @@
******************************************************************************/

AjPTrn ajTrnNewC(const char * filename)
{
    AjPStr trnFileName = NULL;
    return ajTrnNew(trnFileName);
}




/* @func ajTrnNewI ************************************************************
**
** Initialises translation. Reads a translation data file called 'EGC.x'
** where 'x' is supplied as an ajint parameter.
** The filename must exist somewhere in the data path.
** ajTrnDel should be called when translation has ceased.
**
** @param [r] trnFileNameInt [ajint] translation table file name number
** @return [AjPTrn] Translation object
** @category new [AjPTrn] Default constructor
** @@
******************************************************************************/

AjPTrn ajTrnNewI(ajint trnFileNameInt)
{
    AjPStr trnFileName = NULL;
    AjPStr value       = NULL;
    ajStrDel(&value);
    ajStrDel(&trnFileName);

    return ret;
}




/* @func ajTrnNew *************************************************************
**
** Initialises translation. Reads a translation data file
** ajTrnDel should be called when translation has ceased.
**
** @param [r] trnFileName [const AjPStr] translation table file name
** @return [AjPTrn] Translation object
** @category new [AjPTrn] Default constructor
** @@
******************************************************************************/

AjPTrn ajTrnNew(const AjPStr trnFileName)
{
    AjPFile trnFile = NULL;
    AjPTrn pthis;
    ajint i;
    ajint j;
    ajint k;

    /* open the translation table file */

    ajFileClose(&trnFile);

    return pthis;
}




/* @func ajTrnReadFile ********************************************************
**
** Reads a translation data file
**
** The destructor ajTrnDel should be called when translation has ceased.
**
** @param [w] trnObj [AjPTrn] translation table object
** @param [u] trnFile [AjPFile] translation table file handle
** @return [void]
** @category input [AjPTrn] Reads a Genetic Code file
** @@
******************************************************************************/

void ajTrnReadFile(AjPTrn trnObj, AjPFile trnFile)
{
    AjPStr trnLine    = NULL;
    AjPStr trnText    = NULL;
    AjPStr tmpstr     = NULL;
    AjPStr aaline     = NULL;
    AjPStr startsline = NULL;
    AjPStr base1line  = NULL;
    AjPStr base2line  = NULL;
    AjPStr base3line  = NULL;

    AjPStrTok tokenhandle;

    const char *aa;
    const char *starts;
    const char *base1;
    const char *base2;
    const char *base3;
    ajint dlen;
    ajint i;


    /* positions of first use of a residue in the aa line */
    /* ajint firstaa[256]; Now unused */

    /*
    ** NB '-' and '*' are valid characters,
    ** don't skip over them when parsing tokens
    */
    char white[] = " \t\n\r!@#$%^&()_+=|\\~`{[}]:;\"'<,>.?/";

    ajStrDel(&trnText);
    ajStrDel(&startsline);
    ajStrDel(&base1line);
    ajStrDel(&base2line);
    ajStrDel(&base3line);
    ajStrDel(&aaline);
    ajStrDel(&trnLine);

    return;
}




/* @funcstatic trnNoComment ***************************************************
**
** Strips comments from a character string (a line from a trn file).
** Comments are blank lines or any text following a "#" character.
** Whitespace characters can be included in a blank line.
**
** @param [u] text [AjPStr*] Line of text from input file
** @return [void]
** @@
******************************************************************************/

static void trnNoComment(AjPStr* text)
{
    ajint i;
    char *cp;

    ajStrTrimWhite(text);
    i = ajStrGetLen(*text);

    return;
}




/* @func ajTrnNewPep **********************************************************
**
** Creates a new AjPSeq set up with an appropriate name and description
**
** It:
**  Creates a AjPSeq object
**  Sets it to be a protein.
**  Sets the description as being the same as that description of the nucleic
**    acid sequence it was translated from.
**  Gives it the same name as the nucleic acid sequence it is translated from.
**
** If the frame is not specified as being '0' it will then append a '_'
** and the number of the frame to form a unique name for the protein
** sequence in the event of many frames being translated.  If the frame
** number is negative, it will use a number in the range 4, 5, 6, this is
** because ID names with '-' in them were causing problems in the sequence
** reading routines.
**
** Frame 4 is the same as frame -1, 5 is -2, 6 is -3.
**
** You will have to set the sequence of this object with something like:
**  ajSeqAssignSeqS(trnPeptide, seqstr);
**
**
** @param [r] nucleicSeq [const AjPSeq] nucleic sequence being translated
** @param [r] frame [ajint] frame of translation (-3,-2,-1,0,1,2,3,4,5,6)
** @return [AjPSeq] New peptide object
** @category new [AjPSeq] Peptide object constructor
** @@
******************************************************************************/

AjPSeq ajTrnNewPep(const AjPSeq nucleicSeq, ajint frame)
{

    AjPSeq trnPeptide = NULL;
    AjPStr name       = NULL;		/* name of the translation */
    AjPStr value      = NULL;  /* value of frame of the translation */

    ajStrDel(&name);
    ajStrDel(&value);

    return trnPeptide;
}




/* @func ajTrnCodonS ***********************************************************
**
** Translates a codon
**
** @param [r] trnObj [const AjPTrn] Translation tables
** @param [r] codon [const AjPStr] codon to translate
** @return [char] Amino acid translation
** @category use [AjPTrn] Translating a codon from an AjPStr
** @@
******************************************************************************/

char ajTrnCodonS(const AjPTrn trnObj, const AjPStr codon)
{
    const char * res;

    res = ajStrGetPtr(codon);
    return trnObj->GC[trnconv[(ajint)res[0]]]
	             [trnconv[(ajint)res[1]]]
	             [trnconv[(ajint)res[2]]];

}


/* @obsolete ajTrnCodon
** @remove Use ajTrnCodonS
*/

__deprecated const AjPStr ajTrnCodon(const AjPTrn trnObj, const AjPStr codon)
{
    static AjPStr trnResidue = NULL;
    const char * res;
    char store[2];

    store[1] = '\0';			/* end the char * of store */
    ajStrAssignC(&trnResidue, store);

    return trnResidue;
}



/* @func ajTrnCodonRevS ********************************************************
**
** Translates the reverse complement of a codon
**
** @param [r] trnObj [const AjPTrn] Translation tables
** @param [r] codon [const AjPStr] codon to translate
** @return [char] Amino acid translation
** @category use [AjPTrn] Reverse complement translating a codon
**                from an AjPStr
** @@
******************************************************************************/

char ajTrnCodonRevS(const AjPTrn trnObj, const AjPStr codon)
{
    const char * res;

    res = ajStrGetPtr(codon);
    return trnObj->GC[trncomp[(ajint)res[2]]]
	             [trncomp[(ajint)res[1]]]
	             [trncomp[(ajint)res[0]]];
}




/* @obsolete ajTrnRevCodon
** @remove Use ajTrnCodonRevS
*/

__deprecated const AjPStr ajTrnRevCodon(const AjPTrn trnObj, const AjPStr codon)
{
    const char * res;
    char store[2];

    store[1] = '\0';			/* end the char * of store */

    res = ajStrGetPtr(codon);
    store[0] = trnObj->GC[trncomp[(ajint)res[2]]]
	                 [trncomp[(ajint)res[1]]]
	                 [trncomp[(ajint)res[0]]];

    ajStrAssignC(&trnResidueStr, store);

    return trnResidueStr;
}




/* @func ajTrnCodonC **********************************************************
**
** Translates a const char * codon
**
** @param [r] trnObj [const AjPTrn] Translation tables
** @param [r] codon [const char *] codon to translate
**                           (these 3 characters need not be NULL-terminated)
** @return [char] Amino acid translation
** @category use [AjPTrn] Translating a codon from a char* text
** @@
******************************************************************************/

char ajTrnCodonC(const AjPTrn trnObj, const char *codon)
{
    return trnObj->GC[trnconv[(ajint)codon[0]]]
	             [trnconv[(ajint)codon[1]]]
	             [trnconv[(ajint)codon[2]]];
}




/* @func ajTrnCodonRevC *******************************************************
**
** Translates the reverse complement of a const char * codon
**
** @param [r] trnObj [const AjPTrn] Translation tables
** @param [r] codon [const char *] codon to translate
**                           (these 3 characters need not be NULL-terminated)
** @return [char] Amino acid translation
** @category use [AjPTrn] Translating a codon from a char* text
** @@
******************************************************************************/

char ajTrnCodonRevC(const AjPTrn trnObj, const char *codon)
{
    return trnObj->GC[trncomp[(ajint)codon[2]]]
                     [trncomp[(ajint)codon[1]]]
                     [trncomp[(ajint)codon[0]]];
}




/* @func ajTrnCodonK **********************************************************
**
** Translates a const char * codon to a char
**
** @param [r] trnObj [const AjPTrn] Translation tables
** @param [r] codon [const char *] codon to translate
**                           (these 3 characters need not be NULL-terminated)
** @return [char] Amino acid translation
** @category use [AjPTrn] Translating a codon from a char* to a
**                char
** @@
******************************************************************************/

char ajTrnCodonK(const AjPTrn trnObj, const char *codon)
{
    return trnObj->GC[trnconv[(ajint)codon[0]]]
	             [trnconv[(ajint)codon[1]]]
	             [trnconv[(ajint)codon[2]]];
}




/* @func ajTrnRevCodonK *******************************************************
**
** Translates a the reverse complement of a const char * codon to a char
**
** @param [r] trnObj [const AjPTrn] Translation tables
** @param [r] codon [const char *] codon to translate
**                           (these 3 characters need not be NULL-terminated)
** @return [char] Amino acid translation
** @category use [AjPTrn] Reverse complement translating a codon
**                from a char* to a char
** @@
******************************************************************************/

char ajTrnRevCodonK(const AjPTrn trnObj, const char *codon)
{

    return trnObj->GC[trncomp[(ajint)codon[2]]]
	             [trncomp[(ajint)codon[1]]]
	             [trncomp[(ajint)codon[0]]];

}




/* @func ajTrnSeqC ************************************************************
**
** Translates a sequence in a char *
**
** This routine translates in frame 1 (from the first base) to the last full
** triplet codon, (i.e. if there are 1 or 2 bases extra at the end, they are
** ignored)
**
**
** @param [r] trnObj [const AjPTrn] Translation tables
** @param [r] str [const char *] sequence string to translate
** @param [r] len [ajint] length of sequence string to translate
** @param [u] pep [AjPStr *] returned peptide translation (APPENDED TO INPUT)
**
** @return [void]
** @category use [AjPTrn] Translating a sequence from a char* text
** @@
******************************************************************************/

void ajTrnSeqC(const AjPTrn trnObj, const char *str, ajint len, AjPStr *pep)
{
    ajint i;
    ajint lenmod3;
    const char *cp = str;
    AjPStr transtr = NULL;
    char *cq;
    ajint trnlen;

    lenmod3 = len - (len % 3);
    trnlen = lenmod3/3;

    transtr = ajStrNewRes(trnlen+1);
    ajStrDel(&transtr);

    return;
}


/* @obsolete ajTrnC
** @rename ajTrnSeqC
*/

__deprecated void ajTrnC(const AjPTrn trnObj, const char *str, ajint len,
                         AjPStr *pep)
{
    ajTrnSeqC(trnObj, str, len, pep);
    return;
}





/* @func ajTrnSeqRevC *********************************************************
**
** Translates the reverse complement of a sequence in a char *.
**
** This routine translates in frame -1 (using the frame '1' codons)
** to the first full triplet codon,
** (i.e. if there are 1 or 2 bases extra at the start, they are ignored)
**
**
** @param [r] trnObj [const AjPTrn] Translation tables
** @param [r] str [const char *] sequence string to translate
** @param [r] len [ajint] length of sequence string to translate
** @param [u] pep [AjPStr *] returned peptide translation (APPENDED TO INPUT)
**
** @return [void]
** @category use [AjPTrn] Reverse complement translating a sequence
**                from a char* text
** @@
******************************************************************************/

void ajTrnSeqRevC(const AjPTrn trnObj, const char *str, ajint len, AjPStr *pep)
{
    ajint i;
    ajint end;
    const char *cp;

    ajStrSetValidLen(&transtr, trnlen);
    ajStrAppendS(pep, transtr);
    ajStrDel(&transtr);

    return;
}


/* @obsolete ajTrnRevC
** @rename ajTrnSeqRevC
*/

__deprecated void ajTrnRevC(const AjPTrn trnObj, const char *str,
                            ajint len, AjPStr *pep)
{
    ajTrnSeqRevC(trnObj, str, len, pep);
}





/* @func ajTrnSeqAltRevC ******************************************************
**
** Translates the reverse complement of a sequence in a char *.
**
** This routine translates in frame -4 (from the last base) to the first full
** triplet codon, (i.e. if there are 1 or 2 bases extra at the start, they are
** ignored).
** This routine is for those people who define frame '-1' as being the
** frame starting from the first base of a reverse-complemented sequence.
**
**
** @param [r] trnObj [const AjPTrn] Translation tables
** @param [r] str [const char *] sequence string to translate
** @param [r] len [ajint] length of sequence string to translate
** @param [u] pep [AjPStr *] returned peptide translation (APPENDED TO INPUT)
**
** @return [void]
** @category use [AjPTrn] (Alt) Reverse complement translating a
**                sequence from a char* text
** @@
******************************************************************************/

void ajTrnSeqAltRevC(const AjPTrn trnObj, const char *str, ajint len,
                     AjPStr *pep)
{
    ajint i;

    for(i=len-1; i>1; i-=3)
	ajStrAppendK(pep, trnObj->GC[trncomp[(ajint)str[i]]]
		                 [trncomp[(ajint)str[i-1]]]
		                 [trncomp[(ajint)str[i-2]]]);

    return;
}



/* @obsolete ajTrnAltRevC
** @rename ajTrnSeqAltRevC
*/

__deprecated void ajTrnAltRevC(const AjPTrn trnObj, const char *str, ajint len,
                               AjPStr *pep)
{
    ajTrnSeqAltRevC(trnObj, str, len, pep);
    return;
}




/* @func ajTrnSeqS *************************************************************
**
** Translates a sequence in a AjPStr.
**
** This routine translates in frame 1 (from the first base) to the last full
** triplet codon, (i.e. if there are 1 or 2 bases extra at the end, they are
** ignored)
**
**
** @param [r] trnObj [const AjPTrn] Translation tables
** @param [r] str [const AjPStr] sequence string to translate
** @param [u] pep [AjPStr *] returned peptide translation (APPENDED TO INPUT)
**
** @return [void]
** @category use [AjPTrn] Translating a sequence from a
**                AjPStr
** @@
******************************************************************************/

void ajTrnSeqS(const AjPTrn trnObj, const AjPStr str, AjPStr *pep)
{
    ajTrnSeqC(trnObj, ajStrGetPtr(str), ajStrGetLen(str), pep);

    return;
}


/* @obsolete ajTrnStr
** @rename ajTrnSeqS
*/

__deprecated void ajTrnStr(const AjPTrn trnObj, const AjPStr str, AjPStr *pep)
{
    ajTrnSeqS(trnObj, str, pep);
    return;
}




/* @func ajTrnRevStr **********************************************************
**
** Translates the reverse complement of a sequence in a AjPStr.
**
** This routine translates in frame -1 (from the first base) to the last full
** triplet codon, (i.e. if there are 1 or 2 bases extra at the end, they are
** ignored)
**
**
** @param [r] trnObj [const AjPTrn] Translation tables
** @param [r] str [const AjPStr] sequence string to translate
** @param [u] pep [AjPStr *] returned peptide translation (APPENDED TO INPUT)
**
** @return [void]
** @category use [AjPTrn] Reverse complement translating a sequence
**                from a AjPStr
** @@
******************************************************************************/

void ajTrnRevStr(const AjPTrn trnObj, const AjPStr str, AjPStr *pep)
{
    ajTrnSeqRevC(trnObj, ajStrGetPtr(str), ajStrGetLen(str), pep);

    return;
}




/* @func ajTrnSeqAltRevS *******************************************************
**
** Translates the reverse complement of a sequence in a AjPStr.
**
** This routine translates in frame -4 (from the last base) to the first full
** triplet codon, (i.e. if there are 1 or 2 bases extra at the start, they are
** ignored).
** This routine is for those people who define frame '-1' as being the
** frame starting from the first base of a reverse-complemented sequence.
**
**
** @param [r] trnObj [const AjPTrn] Translation tables
** @param [r] str [const AjPStr] sequence string to translate
** @param [u] pep [AjPStr *] returned peptide translation (APPENDED TO INPUT)
**
** @return [void]
** @category use [AjPTrn] (Alt) Reverse complement translating a
**                sequence from a AjPStr
** @@
******************************************************************************/

void ajTrnSeqAltRevS(const AjPTrn trnObj, const AjPStr str, AjPStr *pep)
{
    ajTrnSeqAltRevC(trnObj, ajStrGetPtr(str), ajStrGetLen(str), pep);

    return;
}



/* @obsolete ajTrnAltRevStr
** @rename ajTrnSeqAltRevStr
*/

__deprecated void ajTrnAltRevStr(const AjPTrn trnObj,
                                 const AjPStr str, AjPStr *pep)
{
    ajTrnSeqAltRevS(trnObj, str, pep);
    return;
}




    
/* @func ajTrnSeqSeq **********************************************************
**
** Translates a sequence in a AjPSeq
**
** This routine translates in frame 1 (from the first base) to the last full
** triplet codon, (i.e. if there are 1 or 2 bases extra at the end, they are
** ignored)
**
**
** @param [r] trnObj [const AjPTrn] Translation tables
** @param [r] seq [const AjPSeq] sequence to translate
** @param [u] pep [AjPStr *] returned peptide translation (APPENDED TO INPUT)
**
** @return [void]
** @category use [AjPTrn] Translating a sequence from a
**                AjPSeq
** @@
******************************************************************************/

void ajTrnSeqSeq(const AjPTrn trnObj, const AjPSeq seq, AjPStr *pep)
{
    ajTrnSeqC(trnObj, ajSeqGetSeqC(seq), ajSeqGetLen(seq), pep);

    return;
}


/* @obsolete ajTrnSeq
** @rename ajTrnSeqSeq
*/

__deprecated void ajTrnSeq(const AjPTrn trnObj, const AjPSeq seq, AjPStr *pep)
{
    ajTrnSeqSeq(trnObj, seq, pep);
    return;
}



/* @func ajTrnSeqRevSeq *******************************************************
**
** Translates the reverse complement of a sequence in a AjPSeq
** The translation is APPENDED to the input peptide.
**
** This routine translates in frame 1 (from the first base) to the last full
** triplet codon, (i.e. if there are 1 or 2 bases extra at the end, they are
** ignored)
**
**
** @param [r] trnObj [const AjPTrn] Translation tables
** @param [r] seq [const AjPSeq] sequence to translate
** @param [u] pep [AjPStr *] returned peptide translation (APPENDED TO INPUT)
**
** @return [void]
** @category use [AjPTrn] Reverse complement translating a sequence
**                from a AjPSeq
** @@
******************************************************************************/

void ajTrnSeqRevSeq(const AjPTrn trnObj, const AjPSeq seq, AjPStr *pep)
{
    ajTrnSeqRevC(trnObj, ajSeqGetSeqC(seq), ajSeqGetLen(seq), pep);

    return;
}



/* @obsolete ajTrnRevSeq
** @rename ajTrnSeqRevSeq
*/

__deprecated void ajTrnRevSeq(const AjPTrn trnObj,
                              const AjPSeq seq, AjPStr *pep)
{
    ajTrnSeqRevSeq(trnObj, seq, pep);
}



/* @func ajTrnSeqAltRevSeq *****************************************************
**
** Translates the reverse complement of a sequence in a AjPSeq
** The translation is APPENDED to the input peptide.
**
** This routine translates in frame -4 (from the last base) to the first full
** triplet codon, (i.e. if there are 1 or 2 bases extra at the start, they are
** ignored).
** This routine is for those people who define frame '-1' as being the
** frame starting from the first base of a reverse-complemented sequence.
**
**
**
** @param [r] trnObj [const AjPTrn] Translation tables
** @param [r] seq [const AjPSeq] sequence to translate
** @param [u] pep [AjPStr *] returned peptide translation (APPENDED TO INPUT)
**
** @return [void]
** @category use [AjPTrn] Reverse complement translating a sequence
**                from a AjPSeq
** @@
******************************************************************************/

void ajTrnSeqAltRevSeq(const AjPTrn trnObj, const AjPSeq seq, AjPStr *pep)
{
    ajTrnSeqAltRevC(trnObj, ajSeqGetSeqC(seq), ajSeqGetLen(seq), pep);

    return;
}



/* @obsolete ajTrnAltRevSeq
** @rename ajTrnSeqAltRevSeq
*/

__deprecated void ajTrnAltRevSeq(const AjPTrn trnObj, const AjPSeq seq, AjPStr *pep)
{
    ajTrnSeqAltRevSeq(trnObj, seq, pep);
    return;
}




/* @func ajTrnSeqFrameC ********************************************************
**
** Translates a sequence in a char * in the specified frame.
** The translation is APPENDED to the input peptide.
**
** This routine translates in the specified frame (one of:
** 1,2,3,-1,-2,-3,4,5,6,-4,-5,-6) to the last full triplet codon,
** (i.e.  if there are 1 or 2 bases extra at the end, they are ignored).
**
** Frame -1 is defined as the translation of the reverse complement
** sequence which matches the codons used in frame 1.  i.e.  in the sequence
** ACGT, the first codon of frame 1 is ACG and the last codon of frame -1
** is the reverse complement of ACG (i.e.  CGT).
**
** Frame -4 is defined as the translation from the last base to the first full
** triplet codon.
** This routine is for those people who define frame '-1' as being the
** frame starting from the first base of a reverse-complemented sequence.
** This is also known as the 'alternative frame -1'.
** Frame -5 starts on the penultimate base. (Alternative frame -2)
** Frame -6 starts on the ante-penultimate base. (Alternative frame -3)
**
** Frame 4 is the same as frame -1, 5 is -2, 6 is -3.
**
** @param [r] trnObj [const AjPTrn] Translation tables
** @param [r] seq [const char *] sequence string to translate
** @param [r] len [ajint] length of sequence string to translate
** @param [r] frame [ajint] frame to translate in
** @param [u] pep [AjPStr *] returned peptide translation (APPENDED TO INPUT)
**
** @return [void]
** @category use [AjPTrn] Translating a sequence from a char* in a
**                frame
** @@
******************************************************************************/

void ajTrnSeqFrameC(const AjPTrn trnObj,
                    const char *seq, ajint len,
                    ajint frame, AjPStr *pep)
{

    if(frame > 3)
        frame = -frame + 3;

    if(frame >= 1 && frame <= 3)
    {
	/* len = REAL length passed over */
	ajTrnSeqC(trnObj, &seq[frame-1], len-frame+1, pep);
    }
    else if(frame >= -3 && frame <= -1)
    {
	/* len = REAL length passed over */
	ajTrnSeqRevC(trnObj, &seq[-frame-1], len+frame+1, pep);
    }
    else if(frame >= -6 && frame <= -4)
	ajTrnSeqAltRevC(trnObj, seq, len+frame+4 , pep);
    else
	ajFatal("Invalid frame '%d' in ajTrnSeqFrameC()\n", frame);

    return;
}


/* @obsolete ajTrnCFrame
** @rename ajTrnSeqFrameC
*/

__deprecated void ajTrnCFrame(const AjPTrn trnObj, const char *seq, ajint len, ajint frame,
		 AjPStr *pep)
{

    ajTrnSeqFrameC(trnObj, seq, len, frame, pep);
    return;
}




/* @func ajTrnSeqFrameS *******************************************************
**
** Translates a sequence in a AjStr in the specified frame.
** The translation is APPENDED to the input peptide.
**
** This routine translates in the specified frame (one of:
** 1,2,3,-1,-2,-3,4,5,6,-4,-5,-6) to the last full triplet codon,
** (i.e.  if there are 1 or 2 bases extra at the end, they are ignored).
**
** Frame -1 is defined as the translation of the reverse complement
** sequence which matches the codons used in frame 1.  i.e.  in the sequence
** ACGT, the first codon of frame 1 is ACG and the last codon of frame -1
** is the reverse complement of ACG (i.e.  CGT).
**
** Frame -4 is defined as the translation from the last base to the first full
** triplet codon.
** This routine is for those people who define frame '-1' as being the
** frame starting from the first base of a reverse-complemented sequence.
** This is also known as the 'alternative frame -1'.
** Frame -5 starts on the penultimate base. (Alternative frame -2)
** Frame -6 starts on the ante-penultimate base. (Alternative frame -3)
**
** Frame 4 is the same as frame -1, 5 is -2, 6 is -3.
**
** @param [r] trnObj [const AjPTrn] Translation tables
** @param [r] seq [const AjPStr] sequence string to translate
** @param [r] frame [ajint] frame to translate in
** @param [u] pep [AjPStr *] returned peptide translation (APPENDED TO INPUT)
**
** @return [void]
** @category use [AjPTrn] Translating a sequence from a AjPStr in a
**                frame
** @@
******************************************************************************/

void ajTrnSeqFrameS(const AjPTrn trnObj, const AjPStr seq, ajint frame,
                    AjPStr *pep)
{
    ajTrnSeqFrameC(trnObj, ajStrGetPtr(seq), ajStrGetLen(seq), frame, pep);

    return;
}




/* @obsolete ajTrnStrFrame
** @rename ajTrnSeqFrameS
*/

__deprecated void ajTrnStrFrame(const AjPTrn trnObj,
                                const AjPStr seq, ajint frame,
                                AjPStr *pep)
{
    ajTrnSeqFrameS(trnObj, seq, frame, pep);
    return;
}




/* @func ajTrnSeqFrameSeq *****************************************************
**
** Translates a sequence in a AjSeq in the specified frame.
** The translation is APPENDED to the input peptide.
**
** This routine translates in the specified frame (one of:
** 1,2,3,-1,-2,-3,4,5,6,-4,-5,-6) to the last full triplet codon,
** (i.e.  if there are 1 or 2 bases extra at the end, they are ignored).
**
** Frame -1 is defined as the translation of the reverse complement
** sequence which matches the codons used in frame 1.  i.e.  in the sequence
** ACGT, the first codon of frame 1 is ACG and the last codon of frame -1
** is the reverse complement of ACG (i.e.  CGT).
**
** Frame -4 is defined as the translation from the last base to the first full
** triplet codon.
** This routine is for those people who define frame '-1' as being the
** frame starting from the first base of a reverse-complemented sequence.
** This is also known as the 'alternative frame -1'.
** Frame -5 starts on the penultimate base. (Alternative frame -2)
** Frame -6 starts on the ante-penultimate base. (Alternative frame -3)
**
** Frame 4 is the same as frame -1, 5 is -2, 6 is -3.
**
**
** @param [r] trnObj [const AjPTrn] Translation tables
** @param [r] seq [const AjPSeq] sequence string to translate
** @param [r] frame [ajint] frame to translate in
** @param [u] pep [AjPStr *] returned peptide translation (APPENDED TO INPUT)
**
** @return [void]
** @category use [AjPTrn] Translating a sequence from a AjPSeq in a
**                frame
** @@
******************************************************************************/

void ajTrnSeqFrameSeq(const AjPTrn trnObj, const AjPSeq seq, ajint frame,
                      AjPStr *pep)
{
    ajTrnSeqFrameC(trnObj, ajSeqGetSeqC(seq), ajSeqGetLen(seq), frame, pep);

    return;
}





/* @obsolete ajTrnSeqFrame
** @rename ajTrnSeqFrameSeq
*/

__deprecated void ajTrnSeqFrame(const AjPTrn trnObj, const AjPSeq seq, ajint frame,
		   AjPStr *pep)
{
    ajTrnSeqFrameSeq(trnObj, seq, frame, pep);
    return;
}



/* @func ajTrnSeqFramePep *****************************************************
**
** Translates a sequence in a AjSeq in the specified frame and returns a
** new peptide.
**
** This routine translates in the specified frame (one of:
** 1,2,3,-1,-2,-3,4,5,6,-4,-5,-6) to the last full triplet codon,
** (i.e.  if there are 1 or 2 bases extra at the end, they are ignored).
**
** Frame -1 is defined as the translation of the reverse complement
** sequence which matches the codons used in frame 1.  i.e.  in the sequence
** ACGT, the first codon of frame 1 is ACG and the last codon of frame -1
** is the reverse complement of ACG (i.e.  CGT).
**
** Frame -4 is defined as the translation from the last base to the first full
** triplet codon.
** This routine is for those people who define frame '-1' as being the
** frame starting from the first base of a reverse-complemented sequence.
** This is also known as the 'alternative frame -1'.
** Frame -5 starts on the penultimate base. (Alternative frame -2)
** Frame -6 starts on the ante-penultimate base. (Alternative frame -3)
**
** Frame 4 is the same as frame -1, 5 is -2, 6 is -3.
**
** NB.  that the naming of the output sequence is always to take
** the name of the input sequence (e.g.  ECARGS) and to append an underscore
** character and the frame number 1 to 3 for forward frames and 4 to 6 for
** reverse frames regardless of the final orientation of the reverse
** frames.  (i.e.  frame -1 = ECARGS_4, frame -2 = ECARGS_5, -3 = ECARGS_6, 4 =
** ECARGS_4, 5 = ECARGS_5 6 = ECARGS_6)
**
** @param [r] trnObj [const AjPTrn] Translation tables
** @param [r] seq [const AjPSeq] sequence string to translate
** @param [r] frame [ajint] frame to translate in
**
** @return [AjPSeq] returned peptide translation
** @category use [AjPTrn] Translating a sequence from a AjPSeq in a
**                frame and returns a new peptide
** @@
******************************************************************************/

AjPSeq ajTrnSeqFramePep(const AjPTrn trnObj, const AjPSeq seq, ajint frame)
{
    AjPSeq pep = NULL;
    AjPStr trn = NULL;

    pep = ajTrnNewPep(seq, frame);
    trn = ajStrNew();

    ajTrnSeqFrameSeq(trnObj, seq, frame, &trn);
    ajSeqAssignSeqS(pep, trn);

    ajStrDel(&trn);

    return pep;
}




/* @func ajTrnSeqDangleC ******************************************************
**
** Translates the last 1 or two bases of a sequence in a char *
** that would not be translated if just translating complete codons
** in the specified frame.
** The translation is APPENDED to the input peptide.
**
** @param [r] trnObj [const AjPTrn] Translation tables
** @param [r] seq [const char *] sequence string to translate
** @param [r] frame [ajint] frame to translate in
** @param [u] pep [AjPStr *] returned peptide translation (APPENDED TO INPUT)
**
** @return [ajint] Number of dangling bases (0,1 or 2)
** @category use [AjPTrn] Translates the last 1 or two bases of a
**                sequence in a char* text
** @@
******************************************************************************/

ajint ajTrnSeqDangleC(const AjPTrn trnObj, const char *seq,
                      ajint frame, AjPStr *pep)
{
    ajint end = 0; 	          /* end base of last complete forward codon */
    ajint dangle;		  /* number of bases at the end              */
    ajuint len = strlen(seq);

    if(frame > 3)			/* convert frames 4,5,6 to -1,-2,-3 */
	frame = -frame + 3;

    if(frame > 0)
    {					/* forward 3 frames */
	end = frame + ((len-frame+1)/3)*3 - 1;
	dangle = len - end;
    }
    else if(frame <= -4)		/* alternative reverse frames */
	dangle = (len+frame+4)%3;
    else				/* standard reverse frames */
	dangle = -frame-1;

    /* translate any dangling pair of bases at the end */
    if(dangle == 2)
    {
	if(frame >= 1 && frame <= 3)
	    ajStrAppendK(pep, trnObj->GC[trnconv[(ajint)seq[end]]]
		                     [trnconv[(ajint)seq[end+1]]]
		                     [trnconv[0]]);
	else	/* reverse sense */
	    ajStrAppendK(pep, trnObj->GC[trncomp[(ajint)seq[1]]]
		                     [trncomp[(ajint)seq[0]]]
		                     [trncomp[0]]);
    }
    else if(dangle == 1) /* Make up single base translation */
	ajStrAppendK(pep, 'X');

    return dangle;
}


/* @obsolete ajTrnCDangle
** @rename ajTrnSeqDangleC
*/

__deprecated ajint ajTrnCDangle(const AjPTrn trnObj,
                                const char *seq, ajint len,
                                ajint frame, AjPStr *pep)
{
    (void) len;
    return ajTrnSeqDangleC(trnObj,seq,frame,pep);
}





/* @func ajTrnSeqDangleS *******************************************************
**
** Translates the last 1 or two bases of a sequence in a AjStr
** that would not be translated if just translating complete codons
** in the specified frame.
** The translation is APPENDED to the input peptide.
**
** @param [r] trnObj [const AjPTrn] Translation tables
** @param [r] seq [const AjPStr] sequence string to translate
** @param [r] frame [ajint] frame to translate in
** @param [u] pep [AjPStr *] returned peptide translation (APPENDED TO INPUT)
**
** @return [ajint] Number of dangling bases (0,1 or 2)
**	dangle = len - end;
** @category use [AjPTrn] Translates the last 1 or two bases of a
**                sequence in a AjStr
** @@
******************************************************************************/

ajint ajTrnSeqDangleS(const AjPTrn trnObj, const AjPStr seq, ajint frame,
                      AjPStr *pep)
{
    ajint end = 0; 	          /* end base of last complete forward codon */
    ajint dangle;		  /* number of bases at the end              */
    ajuint len = ajStrGetLen(seq);
    const char* cp = ajStrGetPtr(seq);

    if(frame > 3)			/* convert frames 4,5,6 to -1,-2,-3 */
	frame = -frame + 3;

    if(frame > 0)
    {					/* forward 3 frames */
	end = frame + ((len-frame+1)/3)*3 - 1;
	dangle = len - end;
    }
    else if(frame <= -4)		/* alternative reverse frames */
	dangle = (len+frame+4)%3;
    else				/* standard reverse frames */
	dangle = -frame-1;

    /* translate any dangling pair of bases at the end */
    if(dangle == 2)
    {
	if(frame >= 1 && frame <= 3)
	    ajStrAppendK(pep, trnObj->GC[trnconv[(ajint)cp[end]]]
		                     [trnconv[(ajint)cp[end+1]]]
		                     [trnconv[0]]);
	else	/* reverse sense */
	    ajStrAppendK(pep, trnObj->GC[trncomp[(ajint)cp[1]]]
		                     [trncomp[(ajint)cp[0]]]
		                     [trncomp[0]]);
    }
    else if(dangle == 1) /* Make up single base translation */
	ajStrAppendK(pep, 'X');

    return dangle;
}


/* @obsolete ajTrnStrDangle
** @rename ajTrnDangleS
*/

__deprecated ajint ajTrnStrDangle(const AjPTrn trnObj, const AjPStr seq,
                                  ajint frame, AjPStr *pep)
{
    return ajTrnSeqDangleS(trnObj, seq, frame, pep);
}


/* @func ajTrnSeqOrig *********************************************************
**
** Translates a sequence.
**
** The frame to translate is in the range -3 to 6.
** Frames 1 to 3 give normal forward translations.
**
** Frames -3 to -1 give translations in the reverse sense.
** Frame -1 is defined as the translation of the reverse complement
** sequence which matches the codons used in frame 1.  i.e.  in the sequence
** ACGT, the first codon of frame 1 is ACG and the last codon of frame -1
** is the reverse complement of ACG (i.e.  CGT).
**
** Frames -4 to -6 give translations in the reverse sense.
** Frame -4 is defined as the translation of the reverse complement,
** starting the translation in the first codon of the reversed sequence.
** i.e.  in the sequence ACGT, the last codon is CGT and so frame -4
** translates from the reverse complement of CGT (i.e.  ACG) - this is
** for those people who define frame -1 as using the first codon when the
** sequence is reverse-complemented.
**
** Frames 4 to 6 rev-comp the DNA sequence then reverse the peptide sequence
**
** Frames 4 to 6 are therefore a reversed protein sequence useful mainly for
**  displaying beneath the original DNA sequence.
**
** NB.  that the naming of the output sequence is always to take
** the name of the input sequence (e.g.  ECARGS) and to append an underscore
** character and the frame number 1 to 3 for forward frames and 4 to 6 for
** reverse frames regardless of the final orientation of the reverse
** frames.  (i.e.  frame -1 = ECARGS_4, frame -2 = ECARGS_5, -3 = ECARGS_6, 4 =
** ECARGS_4, 5 = ECARGS_5 6 = ECARGS_6)
**
** @param [r] trnObj [const AjPTrn] Translation tables
** @param [r] seq [const AjPSeq] sequence to translate
** @param [r] frame [ajint] frame to translate in (-6 to 6)
**
** @return [AjPSeq] Peptide translation
** @category use [AjPTrn] Translating a sequence
** @category new [AjPSeq] Translating a sequence
** @@
******************************************************************************/

AjPSeq ajTrnSeqOrig(const AjPTrn trnObj, const AjPSeq seq, ajint frame)
{
    AjPSeq pep = NULL;
    AjPStr trn = NULL;

    pep = ajTrnNewPep(seq, frame);
    trn = ajStrNew();

    ajTrnSeqFrameSeq(trnObj, seq, frame, &trn);

    /*
    ** if there are any dangling bases, then attempt to
    ** translate them
    */
    ajTrnSeqDangleS(trnObj, ajSeqGetSeqS(seq), frame, &trn);

    /*
    ** if frame is 4, 5 or 6 then reverse the peptide for displaying beneath
    ** the original DNA sequence
    */
    if(frame > 3)
	ajStrReverse(&trn);

    ajSeqAssignSeqS(pep, trn);

    ajStrDel(&trn);

    return pep;
}




/* @func ajTrnCodonstrTypeC ***************************************************
**
** Checks whether a const char * codon is a Start codon, a Stop codon or
** something else
**
** @param [r] trnObj [const AjPTrn] Translation tables
** @param [r] codon [const char *] codon to translate
**                           (these 3 characters need not be NULL-terminated)
** @param [w] aa [char *] returned translated amino acid
**                        (not a NULL-terminated array of char)
** @return [ajint] 1 if it is a start codon, -1 if it is a stop codon, else 0
** @category use [AjPTrn] Checks whether a const char* codon is a
**                Start codon, a Stop codon or something else
** @@
******************************************************************************/

ajint ajTrnCodonstrTypeC(const AjPTrn trnObj, const char *codon, char *aa)
{
    ajint tc1;
    ajint tc2;
    ajint tc3;

    tc1 = trnconv[(ajint)codon[0]];
    tc2 = trnconv[(ajint)codon[1]];
    tc3 = trnconv[(ajint)codon[2]];


    *aa = trnObj->GC[tc1][tc2][tc3];

    if(trnObj->Starts[tc1][tc2][tc3] == 'M')
	return 1;

    if(*aa == '*')
	return -1;

    return 0;
}




/* @obsolete ajTrnStartStopC
** @rename ajTrnCodonstrTypeC
*/
__deprecated ajint ajTrnStartStopC(const AjPTrn trnObj,
                                  const char* codon, char *aa)
{
    return ajTrnCodonstrTypeC(trnObj, codon, aa);
}


/* @func ajTrnCodonstrTypeS ****************************************************
**
** Checks whether the input codon is a Start codon, a Stop codon or
** something else
**
** @param [r] trnObj [const AjPTrn] Translation tables
** @param [r] codon [const AjPStr] codon to check
** @param [w] aa [char *] returned translated amino acid
**                        (not a NULL-terminated array of char)
** @return [ajint] 1 if it is a start codon, -1 if it is a stop codon, else 0
** @category use [AjPTrn] Checks whether the input codon is a Start
**                codon, a Stop codon or something else
** @@
******************************************************************************/

ajint ajTrnCodonstrTypeS(const AjPTrn trnObj, const AjPStr codon, char *aa)
{
    const char *res;

    ajint tc1;
    ajint tc2;
    ajint tc3;

    res = ajStrGetPtr(codon);

    tc1 = trnconv[(ajint)res[0]];
    tc2 = trnconv[(ajint)res[1]];
    tc3 = trnconv[(ajint)res[2]];

    *aa = trnObj->GC[tc1][tc2][tc3];

    if(trnObj->Starts[tc1][tc2][tc3] == 'M')
	return 1;

    if(*aa == '*')
	return -1;

    return 0;
}


/* @obsolete ajTrnStartStop
** @rename ajTrnCodonstrTypeS
*/
__deprecated ajint ajTrnStartStop(const AjPTrn trnObj,
                                  const AjPStr codon, char *aa)
{
    return ajTrnCodonstrTypeS(trnObj, codon, aa);
}


/* @func ajTrnGetTitle ********************************************************
**
** Returns the translation table description.
** Because this is a pointer to the real internal string
** the caller must take care not to change the character string in any way.
** If the string is to be changed (case for example) then it must first
** be copied.
**
** @param [r] thys [const AjPTrn] Translation object.
** @return [AjPStr] Description as a string.
** @category cast [AjPTrn] Returns description of the translation
**                table
** @@
******************************************************************************/

AjPStr ajTrnGetTitle(const AjPTrn thys)
{
  return thys->Title;
}




/* @func ajTrnGetFilename *****************************************************
**
** Returns the file that the translation table was read from.
** Because this is a pointer to the real internal string
** the caller must take care not to change the character string in any way.
** If the string is to be changed (case for example) then it must first
** be copied.
**
** @param [r] thys [const AjPTrn] Translation object.
** @return [AjPStr] File name as a string.
** @category cast [AjPTrn] Returns file name the translation table
**                was read from
** @@
******************************************************************************/

AjPStr ajTrnGetFilename(const AjPTrn thys)
{
  return thys->FileName;
}


/* @obsolete ajTrnGetFileName
** @rename ajTrnGetFilename
*/

__deprecated AjPStr ajTrnGetFileName(const AjPTrn thys)
{
  return thys->FileName;
}




/* @func ajTrnName ************************************************************
**
** Checks whether a const char * codon is a Start codon, a Stop codon or
** something else
**
** @param [r] trnFileNameInt [ajint] translation table file name number
** @return [const AjPStr] Genetic code description
** @@
******************************************************************************/

const AjPStr ajTrnName(ajint trnFileNameInt)
{
    const AjPStr ret = NULL;
    AjPStr unknown = NULL;
    AjPFile indexf = NULL;
    AjPStr indexfname = NULL;
    AjPStr line = NULL;
    AjPStr tmpstr = NULL;
    AjPStr tok1 = NULL;
    AjPStr tok2 = NULL;
    AjPStrTok handle = NULL;

    if(!unknown)
	unknown = ajStrNewC("unknown");

    if(!trnCodes)
    {
	if(!indexfname)
	    indexfname = ajStrNewC("EGC.index");

	trnCodes = ajTablestrNewLen(20);

	indexf = ajDatafileNewInNameS(indexfname);

	if(!indexf)
	    return unknown;

	while(ajReadlineTrim(indexf, &line))
	{
	    ajStrTrimWhite(&line);

	    if(ajStrGetCharFirst(line) == '#')
		continue;

	    ajStrTokenAssignC(&handle, line, " ");
	    ajStrTokenNextParse(&handle, &tok1);
	    ajStrTokenRestParse(&handle, &tok2);
	    ajTablePut(trnCodes, tok1, tok2);
	    tok1 = NULL;
	    tok2 = NULL;
	}

	ajFileClose(&indexf);
    }

    ajFmtPrintS(&tmpstr, "%d", trnFileNameInt);
    ret = (AjPStr) ajTableFetch(trnCodes, tmpstr);

    ajStrDel(&unknown);
    ajStrDel(&indexfname);
    ajStrDel(&tok1);
    ajStrDel(&tok2);
    ajStrDel(&line);
    ajStrDel(&tmpstr);
    ajStrTokenDel(&handle);

    if(ret)
	return ret;

    return unknown;
}




/* @funcstatic trnComplete ****************************************************
**
** Completes a translation table.
**
** Checks all basic codons are defined
**
** Sets third base wobble ambiguity codes
**
** Sets most ambiguous codon for each amino acid
**
** @param [u] thys [AjPTrn] Translation table
** @return [AjBool] ajTrue if table was valid and could be set
******************************************************************************/

static AjBool trnComplete(AjPTrn thys)
{
    ajint i;
    ajint j;
    ajint k;
    ajint jj;
    ajint kk;
    ajint ifirst = 0;
    ajint jfirst = 0;
    ajint kfirst = 0;
    ajint newkfirst;
    const char* bases = "ACGT";
    return ajTrue;
}




/*!
** Cleans up translation processing internal memory
**
** @return [void]
** @@
******************************************************************************/

void ajTrnExit(void)
{
    ajStrDel(&trnResidueStr);
    ajTablestrFree(&trnCodes);

    return;
}
