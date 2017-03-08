Received: from mail-oi0-f49.google.com ([209.85.218.49]:36806 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751735AbdCHO5r (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Mar 2017 09:57:47 -0500
Received: by mail-oi0-f49.google.com with SMTP id 126so19807013oig.3
        for <fstests@vger.kernel.org>; Wed, 08 Mar 2017 06:57:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170308115136.GF14226@eguan.usersys.redhat.com>
References: <1488957991-18194-1-git-send-email-zlang@redhat.com>
 <CAOQ4uxhq2h_WEKz1o+_AC8qFT6n6x40eUcBUpoe2eT1pfHAo7w@mail.gmail.com> <20170308115136.GF14226@eguan.usersys.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 8 Mar 2017 16:26:22 +0200
Message-ID: <CAOQ4uxiJKouz9c=91Odd1CsrmkiKcnFuQT1r2V1Fa+UuOm9fxw@mail.gmail.com>
Subject: Re: [PATCH] generic/411: change sub-path name that's duplicate of TEST_DIR
Content-Type: multipart/mixed; boundary=001a11407b32b35e98054a38e9c1
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests <fstests@vger.kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>

--001a11407b32b35e98054a38e9c1
Content-Type: text/plain; charset=UTF-8

On Wed, Mar 8, 2017 at 1:51 PM, Eryu Guan <eguan@redhat.com> wrote:
> On Wed, Mar 08, 2017 at 12:01:33PM +0200, Amir Goldstein wrote:
>> On Wed, Mar 8, 2017 at 9:26 AM, Zorro Lang <zlang@redhat.com> wrote:
>> > Darrick found generic/411 golden output mismatch if use
>> > TEST_DIR=/mnt. Because g/411 use some test path named
>> > /mnt/XXXX/mnt1/mnt2, _filter_test_dir will replace all
>> > "/mnt" things to "TEST_DIR".
>> >
>> > For stop this failure, change all directory names to be
>> > "$seq-XXX", that's less likely to be mistaken for TEST_*
>> > and SCRATCH_*.
>> >
>>
>> Although you have a right to choose whichever names you
>> want top use for your test, this is papering over a bug.
>>
>> I re-read the docuemtnation for \B:
>> http://www.rexegg.com/regex-boundaries.html#bengines
>>
>> To my understanding, the expression "\B$TEST_DIR" will
>> match every instance of $TEST_DIR, where preceding character
>> is NOT a letter, number or underscore.
>> This is because $TEST_DIR must start with '/', which is not
>> a letter, number or underscore.
>>
>> I think it should be safe to fix _filter_test_dir and _filter_scratch.
>
> I agreed, according to the document above, \B matches all positions
> where \b doesn't match. And \b matches positions where "one side is a
> word character and the other side is not", so \B matches "neither side
> is a word character" and "both sides are a word character".
>
> This is also because we canonicalized all mount points, there's no path
> like //mnt/mnt1 is allowed in fstests. And this leads me to wonder if we
> should canonicalize all test devices (if they're block device), to avoid
> something like //dev/sda5? The double "/" will break the \B match.
>

//dev/sda5 does to break \B match.
\B$TEST_DEV match, as you wrote, means that character before
$TEST_DEV *is not* a word character, because $TEST_DEV begins
with a non-word character. it doesn't matter the the second character
is a non-word as well.

Attached a patch that I tested -g quick on xfs and overlayfs
and did not see any regressions, but you better test it with a wider
variety of fs types and a larger group of tests.

> Further more, if we decide to use \B to improve _filter_test_dir and
> _filter_scratch, it appears to me that the fix from commit 4e965d8
> ("fstests: fix test and scratch filters for overlapping DEV/MNT paths")
> can be discarded, the order is not a problem anymore.
>

Well, not exactly.

The case that commit 4e965d8 fixes is:
TEST_DEV=/mnt
TEST_DIR=/mnt/ovl-mnt

So \B$TEST_DEV will still match the prefix of $TEST_DIR and this is
wrong.

However, while $TEST_DEV can really be a prefix of $TEST_DIR
(and will always be a prefix with new -overlay)
I doubt that $TEST_DIR can ever be a prefix of $TEST_DEV.
So instead of the full blown test in commit 4e965d8, it would
suffice to just match $TEST_DIR before $TEST_DEV
(i.e. keep the if case and drop the else case).

So before you test \B with all fs types, you may revert commit 4e965d8,
but please make sure that the resulting filters are in the correct order:

_filter_test_dir()
{
        # TEST_DEV may be a prefix of TEST_DIR (e.g. /mnt and /mnt/ovl-mnt)
        # substitute TEST_DIR first
        sed -e "s,\B$TEST_DIR,TEST_DIR,g" \
               -e "s,\B$TEST_DEV,TEST_DEV,g"
}

_filter_scratch()
{
        # SCRATCH_DEV may be a prefix of SCRATCH_MNT
        # substitute SCRATCH_MNT first
        sed -e "s,\B$SCRATCH_MNT,SCRATCH_MNT,g" \
               -e "s,\B$SCRATCH_DEV,SCRATCH_DEV,g" \
               -e "/.use_space/d"
}

--001a11407b32b35e98054a38e9c1
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-filter-match-TEST_-SCRATCH_-in-beginning-of-path-str.patch"
Content-Disposition: attachment;
	filename="0001-filter-match-TEST_-SCRATCH_-in-beginning-of-path-str.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j011ndyt0

RnJvbSBmMzY1YmQ1ZDYwZDlkNWI4MmUwMmRiMTdlNjE1MzgwYmYzN2E3NGRlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBXZWQsIDggTWFyIDIwMTcgMTI6Mzg6MjIgKzAyMDAKU3ViamVjdDogW1BBVENIXSBmaWx0
ZXI6IG1hdGNoICRURVNUXyogJFNDUkFUQ0hfKiBpbiBiZWdpbm5pbmcgb2YgcGF0aCBzdHJpbmcK
CkZvciBleGFtcGxlLCBpZiAkVEVTVF9ESVI9L21udCwgb25seSByZXBsYWNlIGluc3RhY25lcyBv
ZiAvbW50IHRoYXQKYXJlIGluIHRoZSBiZWdpbm5pbmcgb2YgYSBwYXRoIHN0cmluZywgZS5nLjoK
CiIvbW50L21udEEvbW50QjovbW50L21udEMiID0+ICJURVNUX0RJUi9tbnRBL21udEI6VEVTVF9E
SVIvbW50QyIKClNpZ25lZC1vZmYtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5j
b20+Ci0tLQogY29tbW9uL2ZpbHRlciB8IDE2ICsrKysrKysrLS0tLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCA4IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvY29tbW9u
L2ZpbHRlciBiL2NvbW1vbi9maWx0ZXIKaW5kZXggMWNlYjM0Ni4uMjUwOTQ4MyAxMDA2NDQKLS0t
IGEvY29tbW9uL2ZpbHRlcgorKysgYi9jb21tb24vZmlsdGVyCkBAIC0yODMsMTMgKzI4MywxMyBA
QCBfZmlsdGVyX3Rlc3RfZGlyKCkKIAlpZiAoIGVjaG8gJFRFU1RfRElSIHwgZ3JlcCAtcSAkVEVT
VF9ERVYgKTsgdGhlbgogCQkjIFRFU1RfREVWIGlzIHN1YnN0ciBvZiBURVNUX0RJUiAoZS5nLiAv
bW50IGFuZCAvbW50L292bC1tbnQpCiAJCSMgc3Vic3RpdHV0ZSBURVNUX0RJUiBmaXJzdAotCQlz
ZWQgLWUgInMsJFRFU1RfRElSLFRFU1RfRElSLGciIFwKLQkJICAgIC1lICJzLCRURVNUX0RFVixU
RVNUX0RFVixnIgorCQlzZWQgLWUgInMsXEIkVEVTVF9ESVIsVEVTVF9ESVIsZyIgXAorCQkgICAg
LWUgInMsXEIkVEVTVF9ERVYsVEVTVF9ERVYsZyIKIAllbHNlCiAJCSMgVEVTVF9ESVIgbWF5YmUg
YSBzdWJzdHIgb2YgVEVTVF9ESVIgKGUuZy4gL3ZkYyBhbmQgL2Rldi92ZGMpCiAJCSMgc3Vic3Rp
dHV0ZSBURVNUX0RFViBmaXJzdAotCQlzZWQgLWUgInMsJFRFU1RfREVWLFRFU1RfREVWLGciIFwK
LQkJICAgIC1lICJzLCRURVNUX0RJUixURVNUX0RJUixnIgorCQlzZWQgLWUgInMsXEIkVEVTVF9E
RVYsVEVTVF9ERVYsZyIgXAorCQkgICAgLWUgInMsXEIkVEVTVF9ESVIsVEVTVF9ESVIsZyIKIAlm
aQogfQogCkBAIC0yOTcsMTMgKzI5NywxMyBAQCBfZmlsdGVyX3NjcmF0Y2goKQogewogCWlmICgg
ZWNobyAkU0NSQVRDSF9NTlQgfCBncmVwIC1xICRTQ1JBVENIX0RFViApOyB0aGVuCiAJCSMgU0NS
QVRDSF9ERVYgaXMgc3Vic3RyIG9mIFNDUkFUQ0hfTU5UCi0JCXNlZCAtZSAicywkU0NSQVRDSF9N
TlQsU0NSQVRDSF9NTlQsZyIgXAotCQkgICAgLWUgInMsJFNDUkFUQ0hfREVWLFNDUkFUQ0hfREVW
LGciIFwKKwkJc2VkIC1lICJzLFxCJFNDUkFUQ0hfTU5ULFNDUkFUQ0hfTU5ULGciIFwKKwkJICAg
IC1lICJzLFxCJFNDUkFUQ0hfREVWLFNDUkFUQ0hfREVWLGciIFwKIAkJICAgIC1lICIvLnVzZV9z
cGFjZS9kIgogCWVsc2UKIAkJIyBTQ1JBVENIX01OVCBtYXliZSBhIHN1YnN0ciBvZiBTQ1JBVENI
X0RFVgotCQlzZWQgLWUgInMsJFNDUkFUQ0hfREVWLFNDUkFUQ0hfREVWLGciIFwKLQkJICAgIC1l
ICJzLCRTQ1JBVENIX01OVCxTQ1JBVENIX01OVCxnIiBcCisJCXNlZCAtZSAicyxcQiRTQ1JBVENI
X0RFVixTQ1JBVENIX0RFVixnIiBcCisJCSAgICAtZSAicyxcQiRTQ1JBVENIX01OVCxTQ1JBVENI
X01OVCxnIiBcCiAJCSAgICAtZSAiLy51c2Vfc3BhY2UvZCIKIAlmaQogfQotLSAKMi43LjQKCg==
--001a11407b32b35e98054a38e9c1--
