Received: from mail-oi0-f49.google.com ([209.85.218.49]:35669 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756821AbdCHGuv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Mar 2017 01:50:51 -0500
Received: by mail-oi0-f49.google.com with SMTP id 62so14407228oih.2
        for <fstests@vger.kernel.org>; Tue, 07 Mar 2017 22:50:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170308035045.GN14075@dhcp12-143.nay.redhat.com>
References: <20170307165027.GA15724@birch.djwong.org> <20170308035045.GN14075@dhcp12-143.nay.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 8 Mar 2017 08:50:50 +0200
Message-ID: <CAOQ4uxj=98L4i_F5kBvfYi_gbA5FwuUw0QMz2jGaBqw4D1O6Ww@mail.gmail.com>
Subject: Re: generic/411 clash with TEST_DIR=/mnt
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 8, 2017 at 5:50 AM, Zorro Lang <zlang@redhat.com> wrote:
> On Tue, Mar 07, 2017 at 08:50:27AM -0800, Darrick J. Wong wrote:
>> Hi Zorro,
>>
>> I noticed that generic/411 creates some sort of directory structure
>> involving $TEST_DIR/$seq/$$_mpA/mnt1/mnt2, then pipes the findmnt output
>> through _filter_test_dir.
>>
>> Unfortunately, on my test system I have TEST_DIR=/mnt, so the filtering
>> produces this output:
>>
>> QA output created by 411
>> ------
>> TEST_DIR/411 SCRATCH_DEV
>> mpA SCRATCH_DEV
>> mpATEST_DIR1 SCRATCH_DEV
>> mpB SCRATCH_DEV
>> mpBTEST_DIR1 SCRATCH_DEV
>> mpBTEST_DIR1/TEST_DIR2 SCRATCH_DEV
>> mpC SCRATCH_DEV
>> mpCTESTDIR1 SCRATCH_DEV
>> ======
>
> Hmm, that's really a problem, thanks for finding it:) If someone
> use "/mnt" as TEST_DIR, _filter_test_dir will change all "/mnt"
> things to "TEST_DIR".
>
> Except we recommend all cases shouldn't contain "/mnt"
> in its test path name. Or we'd better change _filter_test_dir,
> make it to be more picky.
>
> I prefer the second way, except someone has a third way :)
>
>> crash test passed
>>
>> Which means that the golden output comparison fails. :(
>>
>> I'm not sure what's a proper fix here: changing _filter_test_dir to be
>> more picky about what gets sed'ed?
>>
>> e.g. sed -e "s,\([[:space:]]\)$TEST_DIR,\1TEST_DIR,g/"
>
> Except [[:space:]]$TEST_DIR, maybe we should think about "^$TEST_DIR" too,
> e.g:
>
> echo "/mnt/mnt1/mnt2     /mnt/mnt3/mnt4" | \
>      sed -e "s,\([[:space:]]\)$TEST_DIR,\1TEST_DIR,g" | \
>      sed -e "s,^$TEST_DIR,TEST_DIR,g"
>

That's not enough.
It's true that currently golden outputs only have ' ' and ^ preceding TEST_DIR,
but why should we limit the solution to TEST_DIR
SCRATCH_MNT could just as well be /mnt and we have SCRATCH_MNT
in golden outputs following '\'' '\"' and : as well.

> (Is there a simpler way to do above things ^^ ? :)
>

I'm not a regexp master, but can't we setup an expression that matches
$TEST_DIR.\S and only replaces the $TEST_DIR part,
that would replace only the first occurrence of  $TEST_DIR is every word.

> But this change will affect lots of cases, we need to run full around
> xfstests to make sure it won't change some cases' golden output. What
> do you think?
>
> Thanks,
> Zorro
>
>>
>> Or just to change the test to use directory names that are less likely to be
>> mistaken for TEST_* and SCRATCH_*?
>>
>> --D
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
