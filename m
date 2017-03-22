Received: from mail-ot0-f195.google.com ([74.125.82.195]:34924 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752783AbdCVBmu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Mar 2017 21:42:50 -0400
Received: by mail-ot0-f195.google.com with SMTP id a12so24259416ota.2
        for <fstests@vger.kernel.org>; Tue, 21 Mar 2017 18:42:49 -0700 (PDT)
In-Reply-To: <20170321213426.GA17542@dastard>
References: <1490087883-24453-1-git-send-email-zlang@redhat.com>
 <1490087883-24453-2-git-send-email-zlang@redhat.com> <CAOQ4uxhfwuGD3NG5xfW11eXJT1LODi-7WyP6z9pPhOKaeFrcOQ@mail.gmail.com>
 <20170321213426.GA17542@dastard>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 Mar 2017 21:42:48 -0400
Message-ID: <CAOQ4uxgZnThGFkXC5TddwbxY_VbZQRQx+wBU5G7PhZaMjkjmiw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] xfs/068: skip new fsstress operations mwrite and mread
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
To: Dave Chinner <david@fromorbit.com>
Cc: Zorro Lang <zlang@redhat.com>, Eric Sandeen <sandeen@sandeen.net>, fstests <fstests@vger.kernel.org>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 21, 2017 at 5:34 PM, Dave Chinner <david@fromorbit.com> wrote:
> On Tue, Mar 21, 2017 at 06:55:31AM -0400, Amir Goldstein wrote:
>> On Tue, Mar 21, 2017 at 5:18 AM, Zorro Lang <zlang@redhat.com> wrote:
>> > The output of x/068 will be perturbed by new fsstress operations.
>> > For keep away breaking x/068's golden image, skip mread and
>> > mwrite which are brought in by a new fsstress patch.
>> >
>> > Reported-by: Eryu Guan <eguan@redhat.com>
>> > Signed-off-by: Zorro Lang <zlang@redhat.com>
>> > ---
>> >  tests/xfs/068 | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/tests/xfs/068 b/tests/xfs/068
>> > index 4dac95e..568ba60 100755
>> > --- a/tests/xfs/068
>> > +++ b/tests/xfs/068
>> > @@ -44,7 +44,7 @@ _supported_fs xfs
>> >  _supported_os Linux
>> >
>> >  # need to ensure new fsstress operations don't perturb expected output
>> > -FSSTRESS_AVOID=3D"-f insert=3D0 $FSSTRESS_AVOID"
>> > +FSSTRESS_AVOID=3D"-f insert=3D0 -f mwrite=3D0 -f mread=3D0 $FSSTRESS_=
AVOID"
>>
>> What?? This is so fragile!
>
> Yet, it is is the existing method for telling fsstress not to run
> certain optionsi on an "as needed" basis:
>
> $ git grep ^FSSTRESS_AVOID
> tests/ext4/307:FSSTRESS_AVOID=3D"$FSSTRESS_AVOID -ffsync=3D0 -fsync=3D0 -=
ffdatasync=3D0"
> tests/generic/019:FSSTRESS_AVOID=3D"$FSSTRESS_AVOID -ffsync=3D0 -fsync=3D=
0 -ffdatasync=3D0 -f setattr=3D1"
> tests/generic/269:FSSTRESS_AVOID=3D"$FSSTRESS_AVOID -ffsync=3D0 -fsync=3D=
0 -ffdatasync=3D0"
> tests/generic/270:FSSTRESS_AVOID=3D"$FSSTRESS_AVOID -ffsync=3D0 -fsync=3D=
0 -ffdatasync=3D0"
> tests/xfs/068:FSSTRESS_AVOID=3D"-f insert=3D0 $FSSTRESS_AVOID"
>

$ git grep -B 1 ^FSSTRESS_AVOID
tests/ext4/307-# Disable all sync operations to get higher load
tests/ext4/307:FSSTRESS_AVOID=3D"$FSSTRESS_AVOID -ffsync=3D0 -fsync=3D0 -ff=
datasync=3D0"
--
tests/generic/019-# Disable all sync operations to get higher load
tests/generic/019:FSSTRESS_AVOID=3D"$FSSTRESS_AVOID -ffsync=3D0 -fsync=3D0
-ffdatasync=3D0 -f setattr=3D1"
--
tests/generic/269-# Disable all sync operations to get higher load
tests/generic/269:FSSTRESS_AVOID=3D"$FSSTRESS_AVOID -ffsync=3D0 -fsync=3D0
-ffdatasync=3D0"
--
tests/generic/270-# Disable all sync operations to get higher load
tests/generic/270:FSSTRESS_AVOID=3D"$FSSTRESS_AVOID -ffsync=3D0 -fsync=3D0
-ffdatasync=3D0"
--
tests/xfs/068-# need to ensure new fsstress operations don't perturb
expected output
tests/xfs/068:FSSTRESS_AVOID=3D"-f insert=3D0 $FSSTRESS_AVOID"

There is a pattern here and xfs/086 doesn't match it.
It is perfectly understandable to want to exclude certain ops that
don't mix well with the test,
but to avoid an op instead of update the output? I am must be missing
the difficulty
of the alternative solution.

>> If the test wanted to restrict fsstress to a pre-defined set of operatio=
ns, then
>> _create_dumpdir_stress_num() should have prefixed '_param' with -z and
>> mention all pre-defined ops (and not only the more frequent ones).
>
> Reality: _create_dumpdir_stress_num(), along with all the other dump
> tests and infrastructure, was ported from the Irix version of
> xfstests way back in:
>
> commit 27fba05e66981c239c3be7a7e5a3aa0d8dc59247
> Author: Nathan Scott <nathans@sgi.com>
> Date:   Mon Jan 15 05:01:19 2001 +0000
>
>     cmd/xfs/stress/001 1.6 Renamed to cmd/xfstests/001
>
> The dump infrastructure is muddy and obtuse, and rather than risk
> breaking other dump tests by changing infrastructure, I simply
> applied the known, accepted method for making fsstress avoid certain
> operations.
>
>> I am very surprised that Dave was the one that made this bandaid.
>
> Reality: Maintainers consider more than just the code when it comes
> to merging things. Encouraging community participation and making
> forwards progress is rather more important than having any single
> change be perfect. IOWs, rather than have things drag on endlessly
> by sending the patchset back to the authors for yet another round of
> review, I simply said "fuck it, no more bikeshedding, we need to
> merge this" and made the obvious, one line change that fixed the
> only regression my testing uncovered.
>

Music to my ears :-)

>
>> Eric,
>>
>> Can you say if adding -z to _create_dumpdir_stress_num() params
>> would be fine with the 2 tests that use it - xfs/022 and xfs/068?
>
> That means dump tests will /never/ exercise new fsstress operations
> which, IMO, is much worse than having to keep a test up to date with
> new operations.
>
> i.e. The whole point of adding new operations to fsstress and have
> tests run them is that we automatically get coverage of new
> functionality. Neutering this for all xfsdump tests by using "-z" is
> - philosophically speaking - the wrong thing to do.
>

Fair enough.
So why exclude the new fsstress operation instead of accomodating 086.out?
philosophically speaking - that would be the right thing to do. No?

>> 068 output would have to be fixed to accommodate this change,
>> but then we can remove the bandaid above and never think of
>> this ever again.
>
> And so never get coverage of new functionality fsstress exposes that
> may affect xfsdump behaviour, and hence we may very well miss
> regressions those new operations cause....

Operations like insert and mmap write....

I think we both agree that Zorro should try to remove the existing bandaid
and fix the expected output. Right?
--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBaQ&c=3DRoP1YumCXCgaWHvlZYR=
8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=
=3Df7fmQEDFpnUZsNLHavw-MwAgqk9wIOJIAy8rwuvPvG8&s=3DD3hzcipuvInwqg6NvynTbbnN=
d3cPfaDoEPOWEmTj5wU&e=3D=20
