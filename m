Received: from mail-yw0-f195.google.com ([209.85.161.195]:46346 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752085AbeBFGpZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 6 Feb 2018 01:45:25 -0500
Received: by mail-yw0-f195.google.com with SMTP id c78so580827ywb.13
        for <fstests@vger.kernel.org>; Mon, 05 Feb 2018 22:45:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180206035443.GN18267@eguan.usersys.redhat.com>
References: <94286394-157a-421b-7f73-52f10529f23f@intel.com> <20180206035443.GN18267@eguan.usersys.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 Feb 2018 08:45:24 +0200
Message-ID: <CAOQ4uxgFYZR6kEVjRcwFOdTN8q=m5L5fyQdhE4dT=dghC5vnMA@mail.gmail.com>
Subject: Re: xfstests failures
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Dave Jiang <dave.jiang@intel.com>, fstests <fstests@vger.kernel.org>, "Zwisler, Ross" <ross.zwisler@intel.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 6, 2018 at 5:54 AM, Eryu Guan <eguan@redhat.com> wrote:
> On Mon, Feb 05, 2018 at 02:40:40PM -0700, Dave Jiang wrote:
>> Eryu,
>> I've noticed that these tests fails under what I think is a normal
>> config (BRD of 48G). We have an expectation that for simple configs all
>> tests in the 'auto' group should pass, and these ones don't. Are these
>
> No, 'auto' group doesn't mean the test should pass, we do add tests
> that're known to fail to auto group, but with the expectation that the
> failures will be fixed in the near future.
>
>> false positive failures?  If so, what do we need to do to remove these
>> false positives?  a) fix the tests to handle these cases b) remove the
>
> And some tests do fail on unusual configs/setups, e.g. 2M extent setting
> in your case, and some tests may not work well with 4k-sector disks.
> We'd want to fix the tests but sometimes it's hard to make test work
> with all configs, perhahs it's just not worth it if the config is
> strange enough and no one cares about it.. But I do like to see the easy
> ones get fixed.
>
>> tests from the 'auto' group?  Something else? Attached file with test
>> outputs. I think some if not all of these failures have lasted many
>> kernel versions.
>>
>> # xfs
>> generic/009
>> generic/012
>> generic/016
>> generic/021
>> generic/022
>> generic/058
>> generic/060
>> generic/061
>> generic/063
>> generic/092
>> generic/255
>> xfs/167
>> xfs/191-input-validation
>
> This tests mkfs.xfs behavior and AFAIK it fails after Dave's mkfs
> refactor patchset, the test itself requires some fixes.
>
>> xfs/242
>> xfs/252
>> xfs/432
>>
>> # ext4
>> generic/388
>
> This is a known issue on ext4, there's a discussion thread on ext4 list.
> https://marc.info/?l=linux-ext4&m=151629719004002&w=2
>

Eryu,

This short thread has shown how much the information about failing tests is
not documented. And that the information is stored only in our
collective brain hive.

For example, how many people out there are able to dig through the
list the find out
the following information about overlay test failures:
016 - long standing known issue - time for a fix unknown
041,42,43 - known issue - resolved by RFC "xino" patches -
                   time for merge unknown
049 - mainline issue - resolved by today's overlayfs-next merge
054,55 - new failing tests with today's mainline - fix patch posted

I know even you did not have the correct information about 017
and thought it should have been failing...

How about maintaining an "expunge" format file with all failing test in
the repository with comment like the above?
We could have 2 files, one for long standing issues like 016,041,042,043
and one for temporary failures, like 054,055

We can debate whether long standing issues should be in auto or not,
but it doesn't hurt to mark them with some group (e.g. "known") that will
point users at the expunge.known file for a reason and for easy way to
exclude those tests.

If you agree to this concept, please start a file and I will add the overlay
failures info to that file.

Thanks,
Amir.
