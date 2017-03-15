Received: from mail-it0-f48.google.com ([209.85.214.48]:36820 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752676AbdCOQcO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Mar 2017 12:32:14 -0400
Received: by mail-it0-f48.google.com with SMTP id w124so52701061itb.1
        for <fstests@vger.kernel.org>; Wed, 15 Mar 2017 09:32:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALz7SpVTJVxZQ0fu-6wWBzXsccNyhndHW52y7E4MoLf6zN5_3Q@mail.gmail.com>
References: <CALz7SpVTJVxZQ0fu-6wWBzXsccNyhndHW52y7E4MoLf6zN5_3Q@mail.gmail.com>
From: Jan Tulak <jtulak@redhat.com>
Date: Wed, 15 Mar 2017 17:31:52 +0100
Message-ID: <CACj3i70iiinR3HJbK_7=gBL5juCATx8WycWDHFWCWReGT=QY6w@mail.gmail.com>
Subject: Re: TEST_DEV
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: John Groves <John@groves.net>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 15, 2017 at 2:24 AM, John Groves <John@groves.net> wrote:
> I'm bringing up a prototype file system under fuse, and I'm new to
> xfstests but trying to use it.  My questions are noob-ish (in xfstest
> context), and I'm happy to rtfm.
>

That's all right. :-)

> My current fuse fs has xfs has a backing file system, plus some
> features that don't come from xfs (backing could just as well be ext4,
> but I don't want fstests to white-box test it as something it's not).
>
> When I set TEST_DEV=/dev/vdb (where xfs is), many tests run; but can
> xfstests run with no TEST_DEV, or a TEST_DEV that points to something
> that it doesn't recognize (and isn't in /proc/mounts)?
>
> I want to test my file system as a black box, for correct behavior.
> Can I do that? (regardless of whether TEST_DEV is involved.)

xfstests, despite its name, works with other filesystems too:

$ ls xfstests/tests/
Makefile cifs     f2fs     ocfs2    shared   xfs
btrfs    ext4     generic  overlay  udf

A lot of tests has something like "_supported_fs xfs", because they
are fs-specific and won't run on other filesystems. Tests in the
'generic' folder should be universal, though.

You need a TEST_DEV (and SCRATCH_DEV for a lot of tests) as a
mountable device, but if you stay with the generic tests, it doesn't
have to be formatted as xfs. Also, FSTYP is another variable I imagine
could be really useful for you (see the readme).

xfstests as a suite doesn't really care what filesystem it is (except
maybe some whitelisting - you might need to add your own name on few
places, but you will see). The specific tests can care, but you don't
have to run them all. Or you can make your set of tests in tests/
directory - each test is just a bash script using a common framework.

Cheers,
Jan

>
> Any tips or pointers appreciated.
>
> Thanks,
> John Groves
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jan Tulak
jtulak@redhat.com / jan@tulak.me
