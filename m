Received: from mail-pf0-f177.google.com ([209.85.192.177]:35983 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755742AbcJXSqQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Oct 2016 14:46:16 -0400
Received: by mail-pf0-f177.google.com with SMTP id e6so103367213pfk.3
        for <fstests@vger.kernel.org>; Mon, 24 Oct 2016 11:46:15 -0700 (PDT)
Received: from google.com ([2620:0:1008:13:e064:b8a8:7485:1b7a])
        by smtp.gmail.com with ESMTPSA id w3sm12402950paa.41.2016.10.24.11.46.13
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Oct 2016 11:46:13 -0700 (PDT)
Date: Mon, 24 Oct 2016 11:46:11 -0700
From: Eric Biggers <ebiggers@google.com>
Subject: xfstests mount options?
Message-ID: <20161024184611.GA83082@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi,

When starting xfstests without $TEST_DEV mounted, it mounts it using this
command in _test_mount, called from init_rc:

    _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR

This is also used by _test_cycle_mount, which some tests use.

This is inconsistent with the later code in _check_generic_filesystem, called
after each test, which remounts $TEST_DEV:

    _mount_or_remount_rw "$MOUNT_OPTIONS" $device $mountpoint

It is possible to have mount options in $MOUNT_OPTIONS which then are *not*
included in the options that _test_mount uses.

$TEST_FS_MOUNT_OPTS is also very strange in that it only appears to ever be set
when testing CIFS.

Which version of the test device mount options is correct?  Is it documented
anywhere what is the correct way to configure the mount options used by
xfstests?

Thanks,

Eric
