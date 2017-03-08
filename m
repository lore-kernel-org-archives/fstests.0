Received: from mail-ot0-f194.google.com ([74.125.82.194]:36171 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753839AbdCHQc1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Mar 2017 11:32:27 -0500
Received: by mail-ot0-f194.google.com with SMTP id i1so4315790ota.3
        for <fstests@vger.kernel.org>; Wed, 08 Mar 2017 08:32:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170308145943.GR14075@dhcp12-143.nay.redhat.com>
References: <1488957991-18194-1-git-send-email-zlang@redhat.com>
 <CAOQ4uxhq2h_WEKz1o+_AC8qFT6n6x40eUcBUpoe2eT1pfHAo7w@mail.gmail.com>
 <20170308115136.GF14226@eguan.usersys.redhat.com> <CAOQ4uxiJKouz9c=91Odd1CsrmkiKcnFuQT1r2V1Fa+UuOm9fxw@mail.gmail.com>
 <20170308145943.GR14075@dhcp12-143.nay.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 8 Mar 2017 18:32:20 +0200
Message-ID: <CAOQ4uxgjyNh9CQGBeFuRZJ755JoLsz29Z5VdWVVYHRQq_Aa7_w@mail.gmail.com>
Subject: Re: [PATCH] generic/411: change sub-path name that's duplicate of TEST_DIR
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests <fstests@vger.kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 8, 2017 at 4:59 PM, Zorro Lang <zlang@redhat.com> wrote:
> On Wed, Mar 08, 2017 at 04:26:22PM +0200, Amir Goldstein wrote:
>> On Wed, Mar 8, 2017 at 1:51 PM, Eryu Guan <eguan@redhat.com> wrote:
>> > On Wed, Mar 08, 2017 at 12:01:33PM +0200, Amir Goldstein wrote:
>> >> On Wed, Mar 8, 2017 at 9:26 AM, Zorro Lang <zlang@redhat.com> wrote:
>> >> > Darrick found generic/411 golden output mismatch if use
>> >> > TEST_DIR=/mnt. Because g/411 use some test path named
>> >> > /mnt/XXXX/mnt1/mnt2, _filter_test_dir will replace all
>> >> > "/mnt" things to "TEST_DIR".
>> >> >
>> >> > For stop this failure, change all directory names to be
>> >> > "$seq-XXX", that's less likely to be mistaken for TEST_*
>> >> > and SCRATCH_*.
>> >> >
>> >>
>> >> Although you have a right to choose whichever names you
>> >> want top use for your test, this is papering over a bug.
>> >>
>> >> I re-read the docuemtnation for \B:
>> >> http://www.rexegg.com/regex-boundaries.html#bengines
>
>
>
> Hmm, I just read this page. This's the first time for me to learn
> about "Regex Boundaries", thanks for your sharing:) So "\B" will
> match:

Heh! it's first time for me too ;-)

>
> [word]\B[word]
> or
> [not-word]\B[not-word]
>
> I think both TEST_* or SCRATCH_* begin with "/", which is not a word.
> (We never use relative path at here, right? ...)
> so if we use "\B$TEST_DIR" we truly expect "[not-word]\B$TEST_DIR"
> ("^" belong to "not a word").
>

That is correct.

>> >>
>> >> To my understanding, the expression "\B$TEST_DIR" will
>> >> match every instance of $TEST_DIR, where preceding character
>> >> is NOT a letter, number or underscore.
>> >> This is because $TEST_DIR must start with '/', which is not
>> >> a letter, number or underscore.
>> >>
>> >> I think it should be safe to fix _filter_test_dir and _filter_scratch.
>> >
>> > I agreed, according to the document above, \B matches all positions
>> > where \b doesn't match. And \b matches positions where "one side is a
>> > word character and the other side is not", so \B matches "neither side
>> > is a word character" and "both sides are a word character".
>> >
>> > This is also because we canonicalized all mount points, there's no path
>> > like //mnt/mnt1 is allowed in fstests. And this leads me to wonder if we
>> > should canonicalize all test devices (if they're block device), to avoid
>> > something like //dev/sda5? The double "/" will break the \B match.
>> >
>>
>> //dev/sda5 does to break \B match.
>> \B$TEST_DEV match, as you wrote, means that character before
>> $TEST_DEV *is not* a word character, because $TEST_DEV begins
>> with a non-word character. it doesn't matter the the second character
>> is a non-word as well.
>>
>> Attached a patch that I tested -g quick on xfs and overlayfs
>> and did not see any regressions, but you better test it with a wider
>> variety of fs types and a larger group of tests.
>>
>> > Further more, if we decide to use \B to improve _filter_test_dir and
>> > _filter_scratch, it appears to me that the fix from commit 4e965d8
>> > ("fstests: fix test and scratch filters for overlapping DEV/MNT paths")
>> > can be discarded, the order is not a problem anymore.
>> >
>>
>> Well, not exactly.
>>
>> The case that commit 4e965d8 fixes is:
>> TEST_DEV=/mnt
>> TEST_DIR=/mnt/ovl-mnt
>>
>> So \B$TEST_DEV will still match the prefix of $TEST_DIR and this is
>> wrong.
>>
>> However, while $TEST_DEV can really be a prefix of $TEST_DIR
>> (and will always be a prefix with new -overlay)
>> I doubt that $TEST_DIR can ever be a prefix of $TEST_DEV.
>> So instead of the full blown test in commit 4e965d8, it would
>> suffice to just match $TEST_DIR before $TEST_DEV
>> (i.e. keep the if case and drop the else case).
>>
>> So before you test \B with all fs types, you may revert commit 4e965d8,
>> but please make sure that the resulting filters are in the correct order:
>>
>> _filter_test_dir()
>> {
>>         # TEST_DEV may be a prefix of TEST_DIR (e.g. /mnt and /mnt/ovl-mnt)
>>         # substitute TEST_DIR first
>>         sed -e "s,\B$TEST_DIR,TEST_DIR,g" \
>>                -e "s,\B$TEST_DEV,TEST_DEV,g"
>> }
>>
>> _filter_scratch()
>> {
>>         # SCRATCH_DEV may be a prefix of SCRATCH_MNT
>>         # substitute SCRATCH_MNT first
>>         sed -e "s,\B$SCRATCH_MNT,SCRATCH_MNT,g" \
>>                -e "s,\B$SCRATCH_DEV,SCRATCH_DEV,g" \
>>                -e "/.use_space/d"
>> }
>
> I just tested this method, generic/411 can work well by this change, even if
> set TEST_DIR=/mnt. But I haven't tested all xfstests cases. If we choose
> this way, it maybe affect lots of cases.
>

But can it really affect lots of cases??

If adding \B can break any test, that means that in some test output,
there exists a pattern [word]$TEST_DIR that is supposed to be
replaced with [word]TEST_DIR.
Even though I find it hard to believe that such case exists, I do not have to
resort to faith. I can use a simple test to verify if [word]TEST_DIR is
expected is golden output:

xfstests-dev$ git grep '\BTEST_DIR' tests/*/*.out
xfstests-dev$ git grep '\BTEST_DEV' tests/*/*.out
xfstests-dev$ git grep '\BSCRATCH_DEV' tests/*/*.out
xfstests-dev$ git grep '\BSCRATCH_MNT' tests/*/*.out

Nothing => Q.E.D


> So there're two ways, change single case and ask all future cases to notice
> this problem, or change common _filter function and make sure all xfstests
> cases can work well. What do you think, Eryu?
>
> Thanks,
> Zorro
>
>> From f365bd5d60d9d5b82e02db17e615380bf37a74de Mon Sep 17 00:00:00 2001
>> From: Amir Goldstein <amir73il@gmail.com>
>> Date: Wed, 8 Mar 2017 12:38:22 +0200
>> Subject: [PATCH] filter: match $TEST_* $SCRATCH_* in beginning of path string
>>
>> For example, if $TEST_DIR=/mnt, only replace instacnes of /mnt that
>> are in the beginning of a path string, e.g.:
>>
>> "/mnt/mntA/mntB:/mnt/mntC" => "TEST_DIR/mntA/mntB:TEST_DIR/mntC"
>>
>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>> ---
>>  common/filter | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/common/filter b/common/filter
>> index 1ceb346..2509483 100644
>> --- a/common/filter
>> +++ b/common/filter
>> @@ -283,13 +283,13 @@ _filter_test_dir()
>>       if ( echo $TEST_DIR | grep -q $TEST_DEV ); then
>>               # TEST_DEV is substr of TEST_DIR (e.g. /mnt and /mnt/ovl-mnt)
>>               # substitute TEST_DIR first
>> -             sed -e "s,$TEST_DIR,TEST_DIR,g" \
>> -                 -e "s,$TEST_DEV,TEST_DEV,g"
>> +             sed -e "s,\B$TEST_DIR,TEST_DIR,g" \
>> +                 -e "s,\B$TEST_DEV,TEST_DEV,g"
>>       else
>>               # TEST_DIR maybe a substr of TEST_DIR (e.g. /vdc and /dev/vdc)
>>               # substitute TEST_DEV first
>> -             sed -e "s,$TEST_DEV,TEST_DEV,g" \
>> -                 -e "s,$TEST_DIR,TEST_DIR,g"
>> +             sed -e "s,\B$TEST_DEV,TEST_DEV,g" \
>> +                 -e "s,\B$TEST_DIR,TEST_DIR,g"
>>       fi
>>  }
>>
>> @@ -297,13 +297,13 @@ _filter_scratch()
>>  {
>>       if ( echo $SCRATCH_MNT | grep -q $SCRATCH_DEV ); then
>>               # SCRATCH_DEV is substr of SCRATCH_MNT
>> -             sed -e "s,$SCRATCH_MNT,SCRATCH_MNT,g" \
>> -                 -e "s,$SCRATCH_DEV,SCRATCH_DEV,g" \
>> +             sed -e "s,\B$SCRATCH_MNT,SCRATCH_MNT,g" \
>> +                 -e "s,\B$SCRATCH_DEV,SCRATCH_DEV,g" \
>>                   -e "/.use_space/d"
>>       else
>>               # SCRATCH_MNT maybe a substr of SCRATCH_DEV
>> -             sed -e "s,$SCRATCH_DEV,SCRATCH_DEV,g" \
>> -                 -e "s,$SCRATCH_MNT,SCRATCH_MNT,g" \
>> +             sed -e "s,\B$SCRATCH_DEV,SCRATCH_DEV,g" \
>> +                 -e "s,\B$SCRATCH_MNT,SCRATCH_MNT,g" \
>>                   -e "/.use_space/d"
>>       fi
>>  }
>> --
>> 2.7.4
>>
>
