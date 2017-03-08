Received: from mail-ot0-f179.google.com ([74.125.82.179]:34217 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751747AbdCHI1s (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Mar 2017 03:27:48 -0500
Received: by mail-ot0-f179.google.com with SMTP id o24so26083507otb.1
        for <fstests@vger.kernel.org>; Wed, 08 Mar 2017 00:27:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170308071446.GP14075@dhcp12-143.nay.redhat.com>
References: <20170307165027.GA15724@birch.djwong.org> <20170308035045.GN14075@dhcp12-143.nay.redhat.com>
 <CAOQ4uxj=98L4i_F5kBvfYi_gbA5FwuUw0QMz2jGaBqw4D1O6Ww@mail.gmail.com> <20170308071446.GP14075@dhcp12-143.nay.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 8 Mar 2017 10:20:19 +0200
Message-ID: <CAOQ4uxjcXGsMzJ5pvJEYTT8=iWGWB62EbLW3ApJoFQNkkjvY=g@mail.gmail.com>
Subject: Re: generic/411 clash with TEST_DIR=/mnt
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 8, 2017 at 9:14 AM, Zorro Lang <zlang@redhat.com> wrote:
> On Wed, Mar 08, 2017 at 08:50:50AM +0200, Amir Goldstein wrote:
>> On Wed, Mar 8, 2017 at 5:50 AM, Zorro Lang <zlang@redhat.com> wrote:
>> > On Tue, Mar 07, 2017 at 08:50:27AM -0800, Darrick J. Wong wrote:
>> >> Hi Zorro,
>> >>
>> >> I noticed that generic/411 creates some sort of directory structure
>> >> involving $TEST_DIR/$seq/$$_mpA/mnt1/mnt2, then pipes the findmnt output
>> >> through _filter_test_dir.
>> >>
>> >> Unfortunately, on my test system I have TEST_DIR=/mnt, so the filtering
>> >> produces this output:
>> >>
>> >> QA output created by 411
>> >> ------
>> >> TEST_DIR/411 SCRATCH_DEV
>> >> mpA SCRATCH_DEV
>> >> mpATEST_DIR1 SCRATCH_DEV
>> >> mpB SCRATCH_DEV
>> >> mpBTEST_DIR1 SCRATCH_DEV
>> >> mpBTEST_DIR1/TEST_DIR2 SCRATCH_DEV
>> >> mpC SCRATCH_DEV
>> >> mpCTESTDIR1 SCRATCH_DEV
>> >> ======
>> >
>> > Hmm, that's really a problem, thanks for finding it:) If someone
>> > use "/mnt" as TEST_DIR, _filter_test_dir will change all "/mnt"
>> > things to "TEST_DIR".
>> >
>> > Except we recommend all cases shouldn't contain "/mnt"
>> > in its test path name. Or we'd better change _filter_test_dir,
>> > make it to be more picky.
>> >
>> > I prefer the second way, except someone has a third way :)
>> >
>> >> crash test passed
>> >>
>> >> Which means that the golden output comparison fails. :(
>> >>
>> >> I'm not sure what's a proper fix here: changing _filter_test_dir to be
>> >> more picky about what gets sed'ed?
>> >>
>> >> e.g. sed -e "s,\([[:space:]]\)$TEST_DIR,\1TEST_DIR,g/"
>> >
>> > Except [[:space:]]$TEST_DIR, maybe we should think about "^$TEST_DIR" too,
>> > e.g:
>> >
>> > echo "/mnt/mnt1/mnt2     /mnt/mnt3/mnt4" | \
>> >      sed -e "s,\([[:space:]]\)$TEST_DIR,\1TEST_DIR,g" | \
>> >      sed -e "s,^$TEST_DIR,TEST_DIR,g"
>> >
>>
>> That's not enough.
>> It's true that currently golden outputs only have ' ' and ^ preceding TEST_DIR,
>> but why should we limit the solution to TEST_DIR
>> SCRATCH_MNT could just as well be /mnt and we have SCRATCH_MNT
>> in golden outputs following '\'' '\"' and : as well.
>
> Hmm, yes, you're right, maybe follow other things... I didn't think
> about this. So change the filter is not easy.
>
>>
>> > (Is there a simpler way to do above things ^^ ? :)
>> >
>>
>> I'm not a regexp master, but can't we setup an expression that matches
>> $TEST_DIR.\S and only replaces the $TEST_DIR part,
>> that would replace only the first occurrence of  $TEST_DIR is every word.
>
> Maybe output $TEST_* or $SCRATCH_* twice in one line.
>
> Maybe there's not a better way to change the filter. Stop all cases using
> sub-path name that's same with $TEST_* or $SCRATCH_* maybe the best way.
>

Or maybe there is

$ echo '/mnt/mnt/mnt /mnt/mnt1/mnt2 "/mnt/mnt/mnt:/mnt/mnt/mnt"' | sed
-e 's,\B/mnt,TEST_DIR,g'
TEST_DIR/mnt/mnt TEST_DIR/mnt1/mnt2 "TEST_DIR/mnt/mnt:TEST_DIR/mnt/mnt"

\b should stand for word boundary, so I thought regexp should use \b, but that
yields the opposite result. \B yields the correct result, but I do not
understand why...?
