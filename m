Received: from mail-vk0-f52.google.com ([209.85.213.52]:35310 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbcF1MoW (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 28 Jun 2016 08:44:22 -0400
Received: by mail-vk0-f52.google.com with SMTP id j2so19940418vkg.2
        for <fstests@vger.kernel.org>; Tue, 28 Jun 2016 05:44:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160628073058.GA23649@eguan.usersys.redhat.com>
References: <1467067222-18286-1-git-send-email-agruenba@redhat.com>
 <1467067222-18286-4-git-send-email-agruenba@redhat.com> <20160628073058.GA23649@eguan.usersys.redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 28 Jun 2016 14:44:19 +0200
Message-ID: <CAHc6FU4BUDHVZA_Dq6oowvqz92wmXwb6bD6PtC6CZcrQ9+83iw@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] generic/362-370: Add richacl tests
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 28, 2016 at 9:30 AM, Eryu Guan <eguan@redhat.com> wrote:
> On Tue, Jun 28, 2016 at 12:40:22AM +0200, Andreas Gruenbacher wrote:
>> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
>
> I looked at this big patch more closely this time (but haven't actually
> run them yet).

On systems without richacl support, the tests will just be skipped.
Actually running them requires a complete richacl setup (kernel, mkfs,
richacl utilities).

> Overall they are all in a good shape to me. I have some more comments inline.
>
>> ---
>>  common/config         |   2 +
>>  common/rc             |  47 +++++++++++++++++
>>  tests/generic/362     | 125 ++++++++++++++++++++++++++++++++++++++++++++
>>  tests/generic/362.out |  94 +++++++++++++++++++++++++++++++++
>>  tests/generic/363     | 117 +++++++++++++++++++++++++++++++++++++++++
>>  tests/generic/363.out | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/generic/364     |  98 +++++++++++++++++++++++++++++++++++
>>  tests/generic/364.out |  39 ++++++++++++++
>>  tests/generic/365     |  91 ++++++++++++++++++++++++++++++++
>>  tests/generic/365.out |   9 ++++
>>  tests/generic/366     |  85 ++++++++++++++++++++++++++++++
>>  tests/generic/366.out |  11 ++++
>>  tests/generic/367     |  84 ++++++++++++++++++++++++++++++
>>  tests/generic/367.out |  11 ++++
>>  tests/generic/368     |  84 ++++++++++++++++++++++++++++++
>>  tests/generic/368.out |   7 +++
>>  tests/generic/369     | 125 ++++++++++++++++++++++++++++++++++++++++++++
>>  tests/generic/369.out |  24 +++++++++
>>  tests/generic/370     |  89 ++++++++++++++++++++++++++++++++
>>  tests/generic/370.out |  19 +++++++
>>  tests/generic/group   |   9 ++++
>>  21 files changed, 1310 insertions(+)
>>  create mode 100755 tests/generic/362
>>  create mode 100644 tests/generic/362.out
>>  create mode 100755 tests/generic/363
>>  create mode 100644 tests/generic/363.out
>>  create mode 100755 tests/generic/364
>>  create mode 100644 tests/generic/364.out
>>  create mode 100755 tests/generic/365
>>  create mode 100644 tests/generic/365.out
>>  create mode 100755 tests/generic/366
>>  create mode 100644 tests/generic/366.out
>>  create mode 100755 tests/generic/367
>>  create mode 100644 tests/generic/367.out
>>  create mode 100755 tests/generic/368
>>  create mode 100644 tests/generic/368.out
>>  create mode 100755 tests/generic/369
>>  create mode 100644 tests/generic/369.out
>>  create mode 100755 tests/generic/370
>>  create mode 100644 tests/generic/370.out
>>
>> diff --git a/common/config b/common/config
>> index c25b1ec..48211ac 100644
>> --- a/common/config
>> +++ b/common/config
>> @@ -196,6 +196,8 @@ export RESTORE_PROG="`set_prog_path restore`"
>>  export LVM_PROG="`set_prog_path lvm`"
>>  export CHATTR_PROG="`set_prog_path chattr`"
>>  export DEBUGFS_PROG="`set_prog_path debugfs`"
>> +export GETRICHACL_PROG="`set_prog_path getrichacl`"
>> +export SETRICHACL_PROG="`set_prog_path setrichacl`"
>>
>>  # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
>>  # newer systems have udevadm command but older systems like RHEL5 don't.
>> diff --git a/common/rc b/common/rc
>> index 4b6ebe5..8bbcfb0 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -2000,6 +2000,53 @@ _runas()
>>       "$here/src/runas" "$@"
>>  }
>>
>> +_require_richacl_prog()
>> +{
>> +     _require_command "$GETRICHACL_PROG" getrichacl
>> +     _require_command "$SETRICHACL_PROG" setrichacl
>> +}
>> +
>> +_require_scratch_richacl_xfs()
>> +{
>> +     _scratch_mkfs_xfs_supported -m richacl=1 >/dev/null 2>&1 \
>> +             || _notrun "mkfs.xfs doesn't have richacl feature"
>> +     _scratch_mkfs_xfs -m richacl=1 >/dev/null 2>&1
>> +     _scratch_mount >/dev/null 2>&1 \
>> +             || _notrun "kernel doesn't support richacl feature on $FSTYP"
>> +     _scratch_unmount
>> +}
>> +
>> +_require_scratch_richacl_ext4()
>> +{
>> +     _scratch_mkfs -O richacl >/dev/null 2>&1 \
>> +             || _notrun "can't mkfs $FSTYP with option -O richacl"
>> +     _scratch_mount >/dev/null 2>&1 \
>> +             || _notrun "kernel doesn't support richacl feature on $FSTYP"
>> +     _scratch_unmount
>> +}
>> +
>> +_require_scratch_richacl()
>> +{
>> +     case "$FSTYP" in
>> +     xfs)    _require_scratch_richacl_xfs
>> +             ;;
>> +     ext4)   _require_scratch_richacl_ext4
>> +             ;;
>> +     *)      _notrun "this test requires richacl support on \$SCRATCH_DEV"
>> +             ;;
>
> I guess NFS and CIFS are going to have richacl support, right? If so, I
> think NFS and CIFS should be supported in _require_scratch_richacl() as
> well, new helpers like _require_scratch_richacl_nfs/cifs can be added if
> necessary.

Yes, eventually they will.

>> +     esac
>> +}
>> +
>> +_scratch_mkfs_richacl()
>> +{
>> +     case "$FSTYP" in
>> +     xfs)    _scratch_mkfs_xfs -m richacl=1
>> +             ;;
>> +     ext4)   _scratch_mkfs -O richacl
>> +             ;;
>
> For NFS and CIFS, all files created by previous runs should be removed
> by calling _scratch_cleanup_files(), you can take a look at
> _scratch_mkfs().

In fact, I can call _scratch_mkfs in those cases.

>> +     esac
>> +}
>> +
>>  # check that a FS on a device is mounted
>>  # if so, return mount point
>>  #
>> diff --git a/tests/generic/362 b/tests/generic/362
>> new file mode 100755
>> index 0000000..91ffe0e
>> --- /dev/null
>> +++ b/tests/generic/362
>> @@ -0,0 +1,125 @@
>> +#! /bin/bash
>> +# FS QA Test 362
>> +#
>> +# RichACL apply-masks test
>> +#
>
> [362 looks good to me, snip]
>
>> diff --git a/tests/generic/363 b/tests/generic/363
>> new file mode 100755
>> index 0000000..8fa6315
>> --- /dev/null
>> +++ b/tests/generic/363
>> @@ -0,0 +1,117 @@
>> +#! /bin/bash
>> +# FS QA Test 363
>> +#
>> +# RichACL auto-inheritance test
>> +#
>> +#-----------------------------------------------------------------------
>> +# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
>> +#
>> +# This program is free software; you can redistribute it and/or
>> +# modify it under the terms of the GNU General Public License as
>> +# published by the Free Software Foundation.
>> +#
>> +# This program is distributed in the hope that it would be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program; if not, write the Free Software Foundation,
>> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> +#-----------------------------------------------------------------------
>> +#
>> +
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1     # failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +     cd /
>> +     rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +_supported_fs generic
>> +_supported_os Linux
>> +
>> +_require_scratch
>> +_require_scratch_richacl
>> +_require_richacl_prog
>> +
>> +_scratch_mkfs_richacl >> $seqres.full
>> +_scratch_mount
>> +
>> +cd $SCRATCH_MNT
>> +
>> +umask 022
>> +
>> +mkdir d1
>> +$SETRICHACL_PROG --modify owner@:rwpxd:fd:allow,u:101:rw:fd:deny d1
>> +$SETRICHACL_PROG --modify u:102:rw:f:deny d1
>> +$SETRICHACL_PROG --modify u:103:rw:d:deny d1
>> +$SETRICHACL_PROG --modify g:101:rw:fdi:deny d1
>> +
>> +$SETRICHACL_PROG --modify flags:a d1
>> +
>> +$GETRICHACL_PROG --numeric --raw d1
>> +
>> +mkdir d1/d2
>> +touch d1/d3
>> +
>> +# Mode bits derived from inherited ACEs
>> +$GETRICHACL_PROG --numeric --raw d1/d2
>> +
>> +$GETRICHACL_PROG --numeric --raw d1/d3
>> +
>> +mkdir d1/d2/d4
>> +touch d1/d2/d4/d5
>> +
>> +# Protected files
>> +mkdir d1/d6
>> +touch d1/d7
>> +
>> +$GETRICHACL_PROG --numeric --raw d1/d2/d4
>> +
>> +$GETRICHACL_PROG --numeric --raw d1/d2/d4/d5
>> +
>> +# Clear protected flag from all the ACLs
>> +$SETRICHACL_PROG --modify flags:a d1/d2
>> +$SETRICHACL_PROG --modify flags:a d1/d3
>> +$SETRICHACL_PROG --modify flags:a d1/d2/d4
>> +$SETRICHACL_PROG --modify flags:a d1/d2/d4/d5
>> +
>> +$GETRICHACL_PROG --numeric d1 | sed -e 's/:fd:deny/:fd:allow/'
>
> What's the purpose of this sed filter? Comments are needed.

Ah, that's a bug. The output should be redirected into acl.txt, which
fixes the below error.

>> +
>> +$SETRICHACL_PROG --set-file acl.txt d1
>
> There's no 'acl.txt' file, and I noticed there's an error message in
> .out file, is this expected, i.e. something you want to test?
>
>  +acl.txt: No such file or directory
>
> If so, a comment would be good to say it's testing --set-file error
> handling by specifying a non-existent file.
>
>> +
>> +$GETRICHACL_PROG --numeric --raw d1
>> +
>> +$GETRICHACL_PROG --numeric --raw d1/d2
>> +
>> +$GETRICHACL_PROG --numeric --raw d1/d3
>> +
>> +$GETRICHACL_PROG --numeric --raw d1/d2/d4
>> +
>> +$GETRICHACL_PROG --numeric --raw d1/d2/d4/d5
>> +
>> +# No automatic inheritance for protected files
>> +$GETRICHACL_PROG --numeric --raw d1/d6
>> +
>> +$GETRICHACL_PROG --numeric --raw d1/d7
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/generic/363.out b/tests/generic/363.out
>> new file mode 100644
>> index 0000000..4eee4a3
>> --- /dev/null
>> +++ b/tests/generic/363.out
>> @@ -0,0 +1,140 @@
>> +QA output created by 363
>> +d1:
>> +     flags:a
>> +     owner:rwpxd-----------::mask
>> +     group:r--x------------::mask
>> +     other:r--x------------::mask
>> +  user:101:rw--------------:fd:deny
>> +  user:102:rw--------------:f:deny
>> +  user:103:rw--------------:d:deny
>> + group:101:rw--------------:fdi:deny
>> +    owner@:rwpxd-----------:fd:allow
>> + everyone@:r--x------------::allow
>> +
>> +d1/d2:
>> +     flags:map
>> +     owner:rwpxd-----------::mask
>> +     group:----------------::mask
>> +     other:----------------::mask
>> +  user:101:rw--------------:fda:deny
>> +  user:102:rw--------------:fia:deny
>> +  user:103:rw--------------:da:deny
>> + group:101:rw--------------:fda:deny
>> +    owner@:rwpxd-----------:fda:allow
>> +
>> +d1/d3:
>> +     flags:map
>> +     owner:rwp-------------::mask
>> +     group:----------------::mask
>> +     other:----------------::mask
>> +  user:101:rw--------------:a:deny
>> +  user:102:rw--------------:a:deny
>> + group:101:rw--------------:a:deny
>> +    owner@:rwpx------------:a:allow
>> +
>> +d1/d2/d4:
>> +     flags:map
>> +     owner:rwpxd-----------::mask
>> +     group:----------------::mask
>> +     other:----------------::mask
>> +  user:101:rw--------------:fda:deny
>> +  user:102:rw--------------:fia:deny
>> +  user:103:rw--------------:da:deny
>> + group:101:rw--------------:fda:deny
>> +    owner@:rwpxd-----------:fda:allow
>> +
>> +d1/d2/d4/d5:
>> +     flags:map
>> +     owner:rwp-------------::mask
>> +     group:----------------::mask
>> +     other:----------------::mask
>> +  user:101:rw--------------:a:deny
>> +  user:102:rw--------------:a:deny
>> + group:101:rw--------------:a:deny
>> +    owner@:rwpx------------:a:allow
>> +
>> +d1:
>> +     flags:a
>> +  user:101:rw-----------:fd:allow
>> +  user:102:rw-----------:f:deny
>> +  user:103:rw-----------:d:deny
>> + group:101:rw-----------:fdi:deny
>> +    owner@:rwpxd--------:fd:allow
>> + everyone@:r--x---------::allow
>> +
>> +acl.txt: No such file or directory
>> +d1:
>> +     flags:a
>> +     owner:rwpxd-----------::mask
>> +     group:r--x------------::mask
>> +     other:r--x------------::mask
>> +  user:101:rw--------------:fd:deny
>> +  user:102:rw--------------:f:deny
>> +  user:103:rw--------------:d:deny
>> + group:101:rw--------------:fdi:deny
>> +    owner@:rwpxd-----------:fd:allow
>> + everyone@:r--x------------::allow
>> +
>> +d1/d2:
>> +     flags:a
>> +     owner:rwpxd-----------::mask
>> +     group:----------------::mask
>> +     other:----------------::mask
>> +  user:101:rw--------------:fda:deny
>> +  user:102:rw--------------:fia:deny
>> +  user:103:rw--------------:da:deny
>> + group:101:rw--------------:fda:deny
>> +    owner@:rwpxd-----------:fda:allow
>> +
>> +d1/d3:
>> +     flags:a
>> +     owner:rwp-------------::mask
>> +     group:----------------::mask
>> +     other:----------------::mask
>> +  user:101:rw--------------:a:deny
>> +  user:102:rw--------------:a:deny
>> + group:101:rw--------------:a:deny
>> +    owner@:rwp-------------:a:allow
>> +
>> +d1/d2/d4:
>> +     flags:a
>> +     owner:rwpxd-----------::mask
>> +     group:----------------::mask
>> +     other:----------------::mask
>> +  user:101:rw--------------:fda:deny
>> +  user:102:rw--------------:fia:deny
>> +  user:103:rw--------------:da:deny
>> + group:101:rw--------------:fda:deny
>> +    owner@:rwpxd-----------:fda:allow
>> +
>> +d1/d2/d4/d5:
>> +     flags:a
>> +     owner:rwp-------------::mask
>> +     group:----------------::mask
>> +     other:----------------::mask
>> +  user:101:rw--------------:a:deny
>> +  user:102:rw--------------:a:deny
>> + group:101:rw--------------:a:deny
>> +    owner@:rwp-------------:a:allow
>> +
>> +d1/d6:
>> +     flags:map
>> +     owner:rwpxd-----------::mask
>> +     group:----------------::mask
>> +     other:----------------::mask
>> +  user:101:rw--------------:fda:deny
>> +  user:102:rw--------------:fia:deny
>> +  user:103:rw--------------:da:deny
>> + group:101:rw--------------:fda:deny
>> +    owner@:rwpxd-----------:fda:allow
>> +
>> +d1/d7:
>> +     flags:map
>> +     owner:rwp-------------::mask
>> +     group:----------------::mask
>> +     other:----------------::mask
>> +  user:101:rw--------------:a:deny
>> +  user:102:rw--------------:a:deny
>> + group:101:rw--------------:a:deny
>> +    owner@:rwpx------------:a:allow
>> +
>> diff --git a/tests/generic/364 b/tests/generic/364
>> new file mode 100755
>> index 0000000..2fc0dfc
>> --- /dev/null
>> +++ b/tests/generic/364
>> @@ -0,0 +1,98 @@
>> +#! /bin/bash
>> +# FS QA Test 364
>> +#
>> +# RichACL basic test
>> +#
>> +#-----------------------------------------------------------------------
>> +# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
>> +#
>> +# This program is free software; you can redistribute it and/or
>> +# modify it under the terms of the GNU General Public License as
>> +# published by the Free Software Foundation.
>> +#
>> +# This program is distributed in the hope that it would be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program; if not, write the Free Software Foundation,
>> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> +#-----------------------------------------------------------------------
>> +#
>> +
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1     # failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +     cd /
>> +     rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +_supported_fs generic
>> +_supported_os Linux
>> +
>> +_require_scratch
>> +_require_scratch_richacl
>> +_require_richacl_prog
>> +
>> +_scratch_mkfs_richacl >> $seqres.full
>> +_scratch_mount
>> +
>> +cd $SCRATCH_MNT
>> +
>> +umask 022
>> +
>> +touch x
>> +
>> +$SETRICHACL_PROG --set 'everyone@:rwp::allow' x
>> +ls -l x | sed -e 's/[. ].*//'
>
> You can use "stat -c %A x" to get the access rights.

Yes, that's better.

>> +$GETRICHACL_PROG x
>> +
>> +chmod 664 x
>> +ls -l x | sed -e 's/[. ].*//'
>> +$GETRICHACL_PROG x
>> +
>> +# Note that unlike how the test cases look at first sight, we do *not* require
>> +# a richacl-enabled version of ls here ...
>> +
>> +mkdir sub
>> +$SETRICHACL_PROG --set 'everyone@:rwpxd:fd:allow' sub
>> +ls -dl sub | sed -e 's/[.+ ].*/+/'
>
> "stat -c %A" works for directory too

Sure, thanks.

>> +getfattr -m system\.richacl sub
>> +
>> +chmod 775 sub
>> +ls -dl sub | sed -e 's/[.+ ].*/+/'
>> +getfattr -m system\.richacl sub
>
> $GETFATTR_PROG

Ok.

>> +$GETRICHACL_PROG sub
>> +
>> +touch sub/f
>> +ls -l sub/f | sed -e 's/[. ].*//'
>> +$GETRICHACL_PROG sub/f
>> +
>> +mkdir sub/sub2
>> +ls -dl sub/sub2 | sed -e 's/[.+ ].*/+/'
>> +$GETRICHACL_PROG sub/sub2
>> +
>> +mkdir -m 750 sub/sub3
>> +ls -dl sub/sub3 | sed -e 's/[.+ ].*/+/'
>> +$GETRICHACL_PROG sub/sub3
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/generic/364.out b/tests/generic/364.out
>> new file mode 100644
>> index 0000000..696cf6c
>> --- /dev/null
>> +++ b/tests/generic/364.out
>> @@ -0,0 +1,39 @@
>> +QA output created by 364
>> +-rw-rw-rw-
>> +x:
>> + everyone@:rwp----------::allow
>> +
>> +-rw-rw-r--
>> +x:
>> +    owner@:rwp----------::allow
>> +    group@:rwp----------::allow
>> + everyone@:r------------::allow
>> +
>> +drwxrwxrwx+
>> +# file: sub
>> +system.richacl
>> +
>> +drwxrwxr-x+
>> +# file: sub
>> +system.richacl
>> +
>> +sub:
>> +    owner@:rwpxd--------::allow
>> +    group@:rwpxd--------::allow
>> + everyone@:rwpxd--------:fdi:allow
>> + everyone@:r--x---------::allow
>> +
>> +-rw-rw-rw-
>> +sub/f:
>> + everyone@:rwp----------::allow
>> +
>> +drwxrwxrwx+
>> +sub/sub2:
>> + everyone@:rwpxd--------:fd:allow
>> +
>> +drwxr-x---+
>> +sub/sub3:
>> +    owner@:rwpxd--------::allow
>> +    group@:r--x---------::allow
>> + everyone@:rwpxd--------:fdi:allow
>> +
>> diff --git a/tests/generic/365 b/tests/generic/365
>> new file mode 100755
>> index 0000000..abaa88f
>> --- /dev/null
>> +++ b/tests/generic/365
>> @@ -0,0 +1,91 @@
>> +#! /bin/bash
>> +# FS QA Test 365
>> +#
>> +# RichACL chmod test
>> +#
>> +#-----------------------------------------------------------------------
>> +# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
>> +#
>> +# This program is free software; you can redistribute it and/or
>> +# modify it under the terms of the GNU General Public License as
>> +# published by the Free Software Foundation.
>> +#
>> +# This program is distributed in the hope that it would be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program; if not, write the Free Software Foundation,
>> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> +#-----------------------------------------------------------------------
>> +#
>> +
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1     # failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +     cd /
>> +     rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +_supported_fs generic
>> +_supported_os Linux
>> +
>> +_require_scratch
>> +_require_scratch_richacl
>> +_require_richacl_prog
>> +_require_runas
>> +
>> +_scratch_mkfs_richacl >> $seqres.full
>> +_scratch_mount
>> +
>> +cd $SCRATCH_MNT
>> +
>> +r() {
>
> "{" in a seperate line, fstests follows this function definition style.

Ok.

>> +     echo "--- runas -u 99 -g 99 $*"
>> +     _runas -u 99 -g 99 -- "$@"
>> +}
>> +
>> +s() {
>> +     echo "--- runas -u 99 -g 99 setrichacl $*"
>> +     _runas -u 99 -g 99 -- $SETRICHACL_PROG "$@"
>> +}
>
> What happens if uid 99 doesn't exist?

Nothing happens, any other number other than 0 would work just as well.

> I think we should add
> _require_user in such tests, and use uid & gid of user $qa_user.
>
> Maybe qa_user_uid and qa_user_gid can be exported in _require_user(), so
> we don't have to get the uid/gid explicitly in each such test.
>
> qa_user_uid=`id -u $qa_user`
> qa_user_gid=`id -g $qa_user`

That's really not needed, numeric UIDs / GIDs work just fine.

> And r() and s() can be updated to echo only "qa_user_uid" and
> "qa_user_gid" to stdout, not fixed "99", e.g.
>
> r()
> {
>         echo "--- runas -u qa_user_uid -g qa_user_gid $*"
>         _runas -u $qa_user_uid -g $qa_user_gid -- "$@"
> }
>
> And .out files should be updated accordingly too.
>
> And I noticed that r() and s() are repeated many times in multiple
> tests, I think they can be moved to common/rc with a proper name.

I'd rather keep them in the tests, they are trivial. Moving them into
common/rc only makes the tests even more difficult to read than they
are already.

> Thanks,
> Eryu
>
>> +
>> +# Create file as root
>> +touch a
>> +
>> +# We cannot set the acl as another user
>> +s --set 'u:99:rwc::allow' a
>> +
>> +# We cannot chmod as another user
>> +r chmod 666 a
>> +
>> +# Give user 99 the write_acl permission
>> +$SETRICHACL_PROG --set 'u:99:rwpC::allow' a
>> +
>> +# Now user 99 can setrichacl and chmod ...
>> +s --set 'u:99:rwpC::allow' a
>> +r chmod 666 a
>> +
>> +# ... but chmod disables the write_acl permission
>> +s --set 'u:99:rwpC::allow' a
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/generic/365.out b/tests/generic/365.out
>> new file mode 100644
>> index 0000000..f7c9242
>> --- /dev/null
>> +++ b/tests/generic/365.out
>> @@ -0,0 +1,9 @@
>> +QA output created by 365
>> +--- runas -u 99 -g 99 setrichacl --set u:99:rwc::allow a
>> +a: Operation not permitted
>> +--- runas -u 99 -g 99 chmod 666 a
>> +chmod: changing permissions of 'a': Operation not permitted
>> +--- runas -u 99 -g 99 setrichacl --set u:99:rwpC::allow a
>> +--- runas -u 99 -g 99 chmod 666 a
>> +--- runas -u 99 -g 99 setrichacl --set u:99:rwpC::allow a
>> +a: Operation not permitted
>> diff --git a/tests/generic/366 b/tests/generic/366
>> new file mode 100755
>> index 0000000..053bfb9
>> --- /dev/null
>> +++ b/tests/generic/366
>> @@ -0,0 +1,85 @@
>> +#! /bin/bash
>> +# FS QA Test 366
>> +#
>> +# RichACL chown test
>> +#
>> +#-----------------------------------------------------------------------
>> +# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
>> +#
>> +# This program is free software; you can redistribute it and/or
>> +# modify it under the terms of the GNU General Public License as
>> +# published by the Free Software Foundation.
>> +#
>> +# This program is distributed in the hope that it would be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program; if not, write the Free Software Foundation,
>> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> +#-----------------------------------------------------------------------
>> +#
>> +
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1     # failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +     cd /
>> +     rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +_supported_fs generic
>> +_supported_os Linux
>> +
>> +_require_scratch
>> +_require_scratch_richacl
>> +_require_richacl_prog
>> +_require_runas
>> +
>> +_scratch_mkfs_richacl >> $seqres.full
>> +_scratch_mount
>> +
>> +cd $SCRATCH_MNT
>> +
>> +r() {
>> +     echo "--- runas -u 99 -g 99 $*"
>> +     _runas -u 99 -g 99 -- "$@"
>> +}
>> +
>> +# Create file as root
>> +touch a
>> +
>> +# Chown and chgrp with no take ownership permission fails
>> +r chown 99 a
>> +r chgrp 99 a
>> +
>> +# Add the take_ownership permission
>> +$SETRICHACL_PROG --set 'u:99:rwpo::allow' a
>> +
>> +# Chown and chgrp to a user or group the process is not in fails
>> +r chown 100 a
>> +r chgrp 100 a
>> +
>> +# Chown and chgrp to a user and group the process is in succeeds
>> +r chown 99 a
>> +r chgrp 99 a
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/generic/366.out b/tests/generic/366.out
>> new file mode 100644
>> index 0000000..d950cc2
>> --- /dev/null
>> +++ b/tests/generic/366.out
>> @@ -0,0 +1,11 @@
>> +QA output created by 366
>> +--- runas -u 99 -g 99 chown 99 a
>> +chown: changing ownership of 'a': Operation not permitted
>> +--- runas -u 99 -g 99 chgrp 99 a
>> +chgrp: changing group of 'a': Operation not permitted
>> +--- runas -u 99 -g 99 chown 100 a
>> +chown: changing ownership of 'a': Operation not permitted
>> +--- runas -u 99 -g 99 chgrp 100 a
>> +chgrp: changing group of 'a': Operation not permitted
>> +--- runas -u 99 -g 99 chown 99 a
>> +--- runas -u 99 -g 99 chgrp 99 a
>> diff --git a/tests/generic/367 b/tests/generic/367
>> new file mode 100755
>> index 0000000..8716ffc
>> --- /dev/null
>> +++ b/tests/generic/367
>> @@ -0,0 +1,84 @@
>> +#! /bin/bash
>> +# FS QA Test 367
>> +#
>> +# RichACL create test
>> +#
>> +#-----------------------------------------------------------------------
>> +# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
>> +#
>> +# This program is free software; you can redistribute it and/or
>> +# modify it under the terms of the GNU General Public License as
>> +# published by the Free Software Foundation.
>> +#
>> +# This program is distributed in the hope that it would be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program; if not, write the Free Software Foundation,
>> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> +#-----------------------------------------------------------------------
>> +#
>> +
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1     # failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +     cd /
>> +     rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +_supported_fs generic
>> +_supported_os Linux
>> +
>> +_require_scratch
>> +_require_scratch_richacl
>> +_require_richacl_prog
>> +_require_runas
>> +
>> +_scratch_mkfs_richacl >> $seqres.full
>> +_scratch_mount
>> +
>> +cd $SCRATCH_MNT
>> +
>> +r() {
>> +     echo "--- runas -u 99 -g 99 $*"
>> +     _runas -u 99 -g 99 -- "$@"
>> +}
>> +
>> +# Create directories as root with different permissions
>> +mkdir d1 d2 d3
>> +$SETRICHACL_PROG --set 'u:99:wx::allow' d2
>> +$SETRICHACL_PROG --set 'u:99:px::allow' d3
>> +
>> +# Cannot create files or directories without permissions
>> +r touch d1/f
>> +r mkdir d1/d
>> +
>> +# Can create files with add_file (w) permission
>> +r touch d2/f
>> +r mkdir d2/d
>> +
>> +# Can create directories with add_subdirectory (p) permission
>> +r touch d3/f
>> +r mkdir d3/d
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/generic/367.out b/tests/generic/367.out
>> new file mode 100644
>> index 0000000..ec25b5c
>> --- /dev/null
>> +++ b/tests/generic/367.out
>> @@ -0,0 +1,11 @@
>> +QA output created by 367
>> +--- runas -u 99 -g 99 touch d1/f
>> +touch: cannot touch 'd1/f': Permission denied
>> +--- runas -u 99 -g 99 mkdir d1/d
>> +mkdir: cannot create directory 'd1/d': Permission denied
>> +--- runas -u 99 -g 99 touch d2/f
>> +--- runas -u 99 -g 99 mkdir d2/d
>> +mkdir: cannot create directory 'd2/d': Permission denied
>> +--- runas -u 99 -g 99 touch d3/f
>> +touch: cannot touch 'd3/f': Permission denied
>> +--- runas -u 99 -g 99 mkdir d3/d
>> diff --git a/tests/generic/368 b/tests/generic/368
>> new file mode 100755
>> index 0000000..36c5fce
>> --- /dev/null
>> +++ b/tests/generic/368
>> @@ -0,0 +1,84 @@
>> +#! /bin/bash
>> +# FS QA Test 368
>> +#
>> +# RichACL ctime test
>> +#
>> +#-----------------------------------------------------------------------
>> +# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
>> +#
>> +# This program is free software; you can redistribute it and/or
>> +# modify it under the terms of the GNU General Public License as
>> +# published by the Free Software Foundation.
>> +#
>> +# This program is distributed in the hope that it would be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program; if not, write the Free Software Foundation,
>> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> +#-----------------------------------------------------------------------
>> +#
>> +
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1     # failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +     cd /
>> +     rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +_supported_fs generic
>> +_supported_os Linux
>> +
>> +_require_scratch
>> +_require_scratch_richacl
>> +_require_richacl_prog
>> +_require_runas
>> +
>> +_scratch_mkfs_richacl >> $seqres.full
>> +_scratch_mount
>> +
>> +cd $SCRATCH_MNT
>> +
>> +r() {
>> +     echo "--- runas -u 99 -g 99 $*"
>> +     _runas -u 99 -g 99 -- "$@"
>> +}
>> +
>> +touch a
>> +
>> +# Without write access, the ctime cannot be changed
>> +r touch a
>> +
>> +$SETRICHACL_PROG --set 'u:99:rw::allow' a
>> +
>> +# With write access, the ctime can be set to the current time, but not to
>> +# any other time
>> +r touch a
>> +r touch -d '1 hour ago' a
>> +
>> +$SETRICHACL_PROG --set 'u:99:rwA::allow' a
>> +
>> +# With set_attributes access, the ctime can be set to an arbitrary time
>> +r touch -d '1 hour ago' a
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/generic/368.out b/tests/generic/368.out
>> new file mode 100644
>> index 0000000..2cdf5e5
>> --- /dev/null
>> +++ b/tests/generic/368.out
>> @@ -0,0 +1,7 @@
>> +QA output created by 368
>> +--- runas -u 99 -g 99 touch a
>> +touch: cannot touch 'a': Permission denied
>> +--- runas -u 99 -g 99 touch a
>> +--- runas -u 99 -g 99 touch -d 1 hour ago a
>> +touch: setting times of 'a': Operation not permitted
>> +--- runas -u 99 -g 99 touch -d 1 hour ago a
>> diff --git a/tests/generic/369 b/tests/generic/369
>> new file mode 100755
>> index 0000000..c64c9ef
>> --- /dev/null
>> +++ b/tests/generic/369
>> @@ -0,0 +1,125 @@
>> +#! /bin/bash
>> +# FS QA Test 369
>> +#
>> +# RichACL delete test
>> +#
>> +#-----------------------------------------------------------------------
>> +# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
>> +#
>> +# This program is free software; you can redistribute it and/or
>> +# modify it under the terms of the GNU General Public License as
>> +# published by the Free Software Foundation.
>> +#
>> +# This program is distributed in the hope that it would be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program; if not, write the Free Software Foundation,
>> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> +#-----------------------------------------------------------------------
>> +#
>> +
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1     # failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +     cd /
>> +     rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +_supported_fs generic
>> +_supported_os Linux
>> +
>> +_require_scratch
>> +_require_scratch_richacl
>> +_require_richacl_prog
>> +_require_runas
>> +
>> +_scratch_mkfs_richacl >> $seqres.full
>> +_scratch_mount
>> +
>> +cd $SCRATCH_MNT
>> +
>> +r() {
>> +     echo "--- runas -u 99 -g 99 $*"
>> +     _runas -u 99 -g 99 -- "$@"
>> +}
>> +
>> +umask 022
>> +
>> +chmod go+w .
>> +mkdir d1 d2 d3 d4 d5 d6 d7
>> +touch d1/f d1/g d2/f d3/f d4/f d5/f d6/f d7/f d7/g d7/h
>> +chmod o+w d1/g
>> +chown 99 d2
>> +chgrp 99 d3
>> +chmod g+w d3
>> +$SETRICHACL_PROG --set 'u:99:wx::allow' d4
>> +$SETRICHACL_PROG --set 'u:99:d::allow' d5
>> +$SETRICHACL_PROG --set 'u:99:xd::allow' d6
>> +$SETRICHACL_PROG --set 'u:99:D::allow' d7/f d7/g d7/h
>> +chmod 664 d7/g
>> +
>> +mkdir s2 s3 s4 s5 s6 s7
>> +chmod +t s2 s3 s4 s5 s6 s7
>> +touch s2/f s3/f s4/f s5/f s6/f s7/f s7/g s7/h
>> +chown 99 s2
>> +chgrp 99 s3
>> +chmod g+w s3
>> +$SETRICHACL_PROG --set 'u:99:wx::allow' s4
>> +$SETRICHACL_PROG --set 'u:99:d::allow' s5
>> +$SETRICHACL_PROG --set 'u:99:xd::allow' s6
>> +$SETRICHACL_PROG --set 'u:99:D::allow' s7/f s7/g s7/h
>> +chmod 664 s7/g
>> +
>> +# Cannot delete files with no or only with write permissions on the directory
>> +r rm -f d1/f d1/g
>> +
>> +# Can delete files in directories we own
>> +r rm -f d2/f s2/f
>> +
>> +# Can delete files in non-sticky directories we have write access to
>> +r rm -f d3/f s3/f
>> +
>> +# "Write_data/execute" access does not include delete_child access, so deleting
>> +# is not allowed:
>> +r rm -f d4/f s4/f
>> +
>> +# "Delete_child" access alone also is not sufficient
>> +r rm -f d5/f s5/f
>> +
>> +# "Execute/delete_child" access is sufficient for non-sticky directories
>> +r rm -f d6/f s6/f
>> +
>> +# "Delete" access on the child is sufficient, even in sticky directories.
>> +r rm -f d7/f s7/f
>> +
>> +# Regression: Delete access must not override add_file / add_subdirectory
>> +# access.
>> +r touch h
>> +r mv -f h d7/
>> +r mv -f h s7/
>> +
>> +# A chmod turns off the "delete" permission
>> +r rm -f d7/g s7/g
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/generic/369.out b/tests/generic/369.out
>> new file mode 100644
>> index 0000000..acdab46
>> --- /dev/null
>> +++ b/tests/generic/369.out
>> @@ -0,0 +1,24 @@
>> +QA output created by 369
>> +--- runas -u 99 -g 99 rm -f d1/f d1/g
>> +rm: cannot remove 'd1/f': Permission denied
>> +rm: cannot remove 'd1/g': Permission denied
>> +--- runas -u 99 -g 99 rm -f d2/f s2/f
>> +--- runas -u 99 -g 99 rm -f d3/f s3/f
>> +rm: cannot remove 's3/f': Operation not permitted
>> +--- runas -u 99 -g 99 rm -f d4/f s4/f
>> +rm: cannot remove 'd4/f': Permission denied
>> +rm: cannot remove 's4/f': Permission denied
>> +--- runas -u 99 -g 99 rm -f d5/f s5/f
>> +rm: cannot remove 'd5/f': Permission denied
>> +rm: cannot remove 's5/f': Permission denied
>> +--- runas -u 99 -g 99 rm -f d6/f s6/f
>> +rm: cannot remove 's6/f': Operation not permitted
>> +--- runas -u 99 -g 99 rm -f d7/f s7/f
>> +--- runas -u 99 -g 99 touch h
>> +--- runas -u 99 -g 99 mv -f h d7/
>> +mv: cannot move 'h' to 'd7/h': Permission denied
>> +--- runas -u 99 -g 99 mv -f h s7/
>> +mv: cannot move 'h' to 's7/h': Permission denied
>> +--- runas -u 99 -g 99 rm -f d7/g s7/g
>> +rm: cannot remove 'd7/g': Permission denied
>> +rm: cannot remove 's7/g': Permission denied
>> diff --git a/tests/generic/370 b/tests/generic/370
>> new file mode 100755
>> index 0000000..a8aaf6c
>> --- /dev/null
>> +++ b/tests/generic/370
>> @@ -0,0 +1,89 @@
>> +#! /bin/bash
>> +# FS QA Test 370
>> +#
>> +# RichACL write-vs-append test
>> +#
>> +#-----------------------------------------------------------------------
>> +# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
>> +#
>> +# This program is free software; you can redistribute it and/or
>> +# modify it under the terms of the GNU General Public License as
>> +# published by the Free Software Foundation.
>> +#
>> +# This program is distributed in the hope that it would be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program; if not, write the Free Software Foundation,
>> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> +#-----------------------------------------------------------------------
>> +#
>> +
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1     # failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +     cd /
>> +     rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +_supported_fs generic
>> +_supported_os Linux
>> +
>> +_require_scratch
>> +_require_scratch_richacl
>> +_require_richacl_prog
>> +_require_runas
>> +
>> +_scratch_mkfs_richacl >> $seqres.full
>> +_scratch_mount
>> +
>> +cd $SCRATCH_MNT
>> +
>> +r() {
>> +     echo "--- runas -u 99 -g 99 $*"
>> +     _runas -u 99 -g 99 -- "$@"
>> +}
>> +
>> +touch a b c d e f
>> +$SETRICHACL_PROG --set 'owner@:rwp::allow' a
>> +$SETRICHACL_PROG --set 'owner@:rwp::allow u:99:w::allow' b
>> +$SETRICHACL_PROG --set 'owner@:rwp::allow u:99:p::allow' c
>> +$SETRICHACL_PROG --set 'owner@:rwp::allow u:99:wp::allow' d
>> +$SETRICHACL_PROG --set 'u:99:a::deny owner@:rwp::allow u:99:w::allow' e
>> +$SETRICHACL_PROG --set 'u:99:w::deny owner@:rwp::allow u:99:p::allow' f
>> +
>> +r sh -c 'echo a > a'
>> +r sh -c 'echo b > b'
>> +r sh -c 'echo c > c'
>> +r sh -c 'echo d > d'
>> +r sh -c 'echo e > e'
>> +r sh -c 'echo f > f'
>> +
>> +r sh -c 'echo A >> a'
>> +r sh -c 'echo B >> b'
>> +r sh -c 'echo C >> c'
>> +r sh -c 'echo D >> d'
>> +r sh -c 'echo E >> e'
>> +r sh -c 'echo F >> f'
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/generic/370.out b/tests/generic/370.out
>> new file mode 100644
>> index 0000000..97a21a1
>> --- /dev/null
>> +++ b/tests/generic/370.out
>> @@ -0,0 +1,19 @@
>> +QA output created by 370
>> +--- runas -u 99 -g 99 sh -c echo a > a
>> +sh: a: Permission denied
>> +--- runas -u 99 -g 99 sh -c echo b > b
>> +--- runas -u 99 -g 99 sh -c echo c > c
>> +sh: c: Permission denied
>> +--- runas -u 99 -g 99 sh -c echo d > d
>> +--- runas -u 99 -g 99 sh -c echo e > e
>> +--- runas -u 99 -g 99 sh -c echo f > f
>> +sh: f: Permission denied
>> +--- runas -u 99 -g 99 sh -c echo A >> a
>> +sh: a: Permission denied
>> +--- runas -u 99 -g 99 sh -c echo B >> b
>> +sh: b: Permission denied
>> +--- runas -u 99 -g 99 sh -c echo C >> c
>> +--- runas -u 99 -g 99 sh -c echo D >> d
>> +--- runas -u 99 -g 99 sh -c echo E >> e
>> +sh: e: Permission denied
>> +--- runas -u 99 -g 99 sh -c echo F >> f
>> diff --git a/tests/generic/group b/tests/generic/group
>> index 7491282..2ec4288 100644
>> --- a/tests/generic/group
>> +++ b/tests/generic/group
>> @@ -364,3 +364,12 @@
>>  359 auto quick clone
>>  360 auto quick metadata
>>  361 auto quick
>> +362 auto quick richacl
>> +363 auto quick richacl
>> +364 auto quick richacl
>> +365 auto quick richacl
>> +366 auto quick richacl
>> +367 auto quick richacl
>> +368 auto quick richacl
>> +369 auto quick richacl
>> +370 auto quick richacl
>> --
>> 2.5.5

Updated patch coming.

Thanks,
Andreas
