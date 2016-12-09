Received: from mail-qk0-f195.google.com ([209.85.220.195]:36469 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbcLIUfi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 9 Dec 2016 15:35:38 -0500
Received: by mail-qk0-f195.google.com with SMTP id h201so3652168qke.3
        for <fstests@vger.kernel.org>; Fri, 09 Dec 2016 12:35:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1476877814-29310-1-git-send-email-agruenba@redhat.com>
References: <1476877814-29310-1-git-send-email-agruenba@redhat.com>
From: Ross Zwisler <zwisler@gmail.com>
Date: Fri, 9 Dec 2016 13:35:36 -0700
Message-ID: <CAOxpaSUMJ13=o0oudfBUZXzXe6sxKRvhnBbAtmd75q_S2R57mQ@mail.gmail.com>
Subject: Re: [PATCH] generic: Check linking O_TMPFILE into namespace with
 POSIX ACLs
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Andreas Gruenbacher <agruenba@redhat.com>, Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Oct 19, 2016 at 5:50 AM, Andreas Gruenbacher
<agruenba@redhat.com> wrote:
>
> When an O_TMPFILE file is linked into a directory with a POSIX default
> ACL, the file should inherit the default ACL and the umask needs to be
> ignored.
>
> This goes together with generic/004, which tests O_TMPFILE files without
> POSIX ACLs.
>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

I can't seem to get this test to pass.  It fails for me with PMEM and
BRD devices, and with XFS, ext4 and ext2.

Here is an easily reproducible failure with xfs and two 2GiB BRD ram
disks for the TEST_DEV and SCRATCH_DEV:

# ./check generic/389
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 alara 4.9.0-rc8
MKFS_OPTIONS  -- -f -bsize=4096 /dev/ram1
MOUNT_OPTIONS -- -o context=system_u:object_r:nfs_t:s0 /dev/ram1
/mnt/xfstests_scratch

generic/389 - output mismatch (see /root/xfstests/results//generic/389.out.bad)
    --- tests/generic/389.out 2016-12-09 13:17:21.874927856 -0700
    +++ /root/xfstests/results//generic/389.out.bad 2016-12-09
13:31:22.831911244 -0700
    @@ -1,6 +1,2 @@
     QA output created by 389
    -wrote 4096/4096 bytes at offset 0
    -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -read 4096/4096 bytes at offset 0
    -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -664
    +stat: cannot stat '/mnt/xfstests_test/d.389/tst-tmpfile-flink':
No such file or directory
    ...
    (Run 'diff -u tests/generic/389.out
/root/xfstests/results//generic/389.out.bad'  to see the entire diff)
Ran: generic/389
Failures: generic/389
Failed 1 of 1 tests

This is using vanilla v4.9.0-rc8 and the following xfstests commit:

adcc60c build: allow building with latest xfslibs on 32-bit Linux

Is the test broken?
