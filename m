Received: from mx1.redhat.com ([209.132.183.28]:60152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751198AbcLSH0c (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 19 Dec 2016 02:26:32 -0500
Date: Mon, 19 Dec 2016 15:26:28 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v4 6/6] generic: test for weaknesses in filesystem
 encryption
Message-ID: <20161219072628.GC1859@eguan.usersys.redhat.com>
References: <1481833585-39148-1-git-send-email-ebiggers3@gmail.com>
 <1481833585-39148-7-git-send-email-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481833585-39148-7-git-send-email-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Richard Weinberger <richard@nod.at>, David Gstir <david@sigma-star.at>, Michael Halcrow <mhalcrow@google.com>, Eric Sandeen <sandeen@redhat.com>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Dec 15, 2016 at 12:26:25PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add an xfstest which can detect some basic crypto mistakes that would
> reduce the confidentiality guarantee provided by filesystem encryption.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  common/config         |   1 +
>  tests/generic/404     | 162 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/404.out |   3 +
>  tests/generic/group   |   1 +
>  4 files changed, 167 insertions(+)
>  create mode 100755 tests/generic/404
>  create mode 100644 tests/generic/404.out
> 
> diff --git a/common/config b/common/config
> index 3727ec0..6cce7ce 100644
> --- a/common/config
> +++ b/common/config
> @@ -203,6 +203,7 @@ export UUIDGEN_PROG="`set_prog_path uuidgen`"
>  export GETRICHACL_PROG="`set_prog_path getrichacl`"
>  export SETRICHACL_PROG="`set_prog_path setrichacl`"
>  export KEYCTL_PROG="`set_prog_path keyctl`"
> +export XZ_PROG="`set_prog_path xz`"
>  
>  # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
>  # newer systems have udevadm command but older systems like RHEL5 don't.
> diff --git a/tests/generic/404 b/tests/generic/404
> new file mode 100755
> index 0000000..3d96f8f
> --- /dev/null
> +++ b/tests/generic/404
> @@ -0,0 +1,162 @@
> +#! /bin/bash
> +# FS QA Test generic/404
> +#
> +# Check for weaknesses in filesystem encryption involving the same ciphertext
> +# being repeated.  For file contents, we fill a small filesystem with large
> +# files of 0's and verify the filesystem is incompressible.  For filenames, we
> +# create an identical symlink in two different directories and verify the
> +# ciphertext filenames and symlink targets are different.
> +#
> +# This test can detect some basic cryptographic mistakes such as nonce reuse
> +# (across files), initialization vector reuse (across blocks), or data somehow
> +# being left in plaintext by accident.  For example, it detects the
> +# initialization vector reuse bug fixed in commit 02fc59a0d28f ("f2fs/crypto:
> +# fix xts_tweak initialization").
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2016 Google, Inc.  All Rights Reserved.
> +#
> +# Author: Eric Biggers <ebiggers@google.com>
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#-----------------------------------------------------------------------
> +#
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/encrypt
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch_encryption
> +_require_xfs_io_command "set_encpolicy"
> +_require_command "$XZ_PROG" xz
> +_require_command "$KEYCTL_PROG" keyctl
> +
> +_new_session_keyring
> +
> +# Set up a small filesystem containing an encrypted directory.  64 MB is enough
> +# for both ext4 and f2fs.  (f2fs doesn't support a 32 MB filesystem.)
> +fs_size_in_mb=64
> +fs_size=$((fs_size_in_mb * 1024 * 1024))
> +dd if=/dev/zero of=$SCRATCH_DEV bs=$((1024 * 1024)) \
> +	count=$fs_size_in_mb &>> $seqres.full

Why is zeroing out the first 64M of SCRATCH_DEV necessary? Better to
have some comments on it.

> +MKFS_OPTIONS="$MKFS_OPTIONS -O encrypt" \
> +	_scratch_mkfs_sized $fs_size &>> $seqres.full
> +_scratch_mount
> +
> +keydesc=$(_generate_encryption_key)
> +mkdir $SCRATCH_MNT/encrypted_dir
> +$XFS_IO_PROG -c "set_encpolicy $keydesc" $SCRATCH_MNT/encrypted_dir
> +
> +# Create the "same" symlink in two different directories.
> +# Later we'll check both the name and target of the symlink.
> +mkdir $SCRATCH_MNT/encrypted_dir/subdir1
> +mkdir $SCRATCH_MNT/encrypted_dir/subdir2
> +ln -s symlink_target $SCRATCH_MNT/encrypted_dir/subdir1/symlink
> +ln -s symlink_target $SCRATCH_MNT/encrypted_dir/subdir2/symlink
> +
> +#
> +# Write files of 1 MB of all the same byte until we hit ENOSPC.  Note that we
> +# must not create sparse files, since the contents of sparse files are not
> +# stored on-disk.  Also, we create multiple files rather than one big file
> +# because we want to test for reuse of per-file keys.
> +#
> +total_file_size=0
> +i=1
> +while true; do
> +	file=$SCRATCH_MNT/encrypted_dir/file$i
> +	if ! xfs_io -f $file -c 'pwrite 0 1M' &> $tmp.out; then

Use $XFS_IO_PROG here.

Can you please send an updated patch 6/6? Otherwise the whole series
look good to me! I'm going to let the patchset sit in the list for
another week and push them out to upstream in next fstests update, if
there's no further comments from others.

Thanks,
Eryu
