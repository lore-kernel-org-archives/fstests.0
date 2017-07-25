Received: from mx1.redhat.com ([209.132.183.28]:35594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750757AbdGYITo (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 25 Jul 2017 04:19:44 -0400
Date: Tue, 25 Jul 2017 16:19:42 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] ext4: add a test for ea_inode feature
Message-ID: <20170725081942.GP9167@eguan.usersys.redhat.com>
References: <20170720013636.7620-1-tahsin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170720013636.7620-1-tahsin@google.com>
Sender: fstests-owner@vger.kernel.org
To: Tahsin Erdogan <tahsin@google.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 19, 2017 at 06:36:36PM -0700, Tahsin Erdogan wrote:
> ea_inode feature supports creating extended attributes with values
> greater than the fs block size. This test exercises some common
> scenarios:
> 
>  - Extended attibute being placed in inode vs xattr block
>  - Removing extended attribute
>  - Removing a file that has an extended attribute
>  - Multiple files having identical large attribute values
>  - Repeatedly setting an extended attribute with various sizes
> 
> Signed-off-by: Tahsin Erdogan <tahsin@google.com>

Test looks fine to me overall, but I'd like ext4 developers to help
review too.

Some minor nits inline.

> ---
>  tests/ext4/026     | 134 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/026.out |  29 ++++++++++++
>  tests/ext4/group   |   1 +
>  3 files changed, 164 insertions(+)
>  create mode 100755 tests/ext4/026
>  create mode 100644 tests/ext4/026.out
> 
> diff --git a/tests/ext4/026 b/tests/ext4/026
> new file mode 100755
> index 000000000000..297232ba7092
> --- /dev/null
> +++ b/tests/ext4/026
> @@ -0,0 +1,134 @@
> +#! /bin/bash
> +# FS QA Test 026
> +#
> +# Test ea_inode feature.

Better to have more information about ea_inode feature and what this
case tests here too.

> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2017 Google, Inc.  All Rights Reserved.
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
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/attr
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs ext4
> +_supported_os Linux
> +_require_scratch
> +_require_attrs
> +_require_ext4_mkfs_feature ea_inode
> +
> +_scratch_mkfs_ext4 -O ea_inode -I 256 -b 4096 >/dev/null 2>&1

Is 4k block size a hard requirement? If not, then we lose test coverage
for 1k/2k block size ext4, if so, some comments on it would be better.
(and the 256 inode size too).

> +_scratch_mount
> +
> +# Sets an extended attribute on a file.
> +attr_set()
> +{
> +	local file=$1 name=$2 value=$3 tmp
> +
> +	if [[ "$value" != "" ]]; then
> +		setfattr -n $name -v "$value" $file

You can use $SETFATTR_PROG and $GETFATTR_PROG in the test.

> +	else
> +		setfattr -n $name $file
> +	fi
> +
> +	tmp=$(getfattr --absolute-names --only-values -n $name $file)
> +	[[ $tmp == $value ]] || echo "unexpected value returned: $tmp"

Better to get $tmp and $value quoted with "", otherwise if any value is
empty, it's a bash syntax error.

Thanks,
Eryu

> +}
> +
> +# List attributes on a file.
> +attr_list()
> +{
> +	getfattr --absolute-names $1 | grep -v '^#'
> +}
> +
> +# Removes an extended attribute from a file.
> +attr_remove()
> +{
> +	local file=$1 name=$2
> +
> +	setfattr -x $name $file
> +}
> +
> +# Test files.
> +x=$SCRATCH_MNT/x
> +y=$SCRATCH_MNT/y
> +z=$SCRATCH_MNT/z
> +
> +# Attribute with short name that goes into inode body.
> +name_in_ibody=user.i
> +
> +# Attribute with long name that goes into xattr block.
> +name_in_block=user.$(perl -e 'print "b" x 100;')
> +
> +# Set large xattr values on multiple files.
> +touch $x $y $z
> +for file in $x $y $z; do
> +	for name in $name_in_ibody $name_in_block; do
> +		for size in 4096 8000 $((64*1024)); do
> +			attr_set $file $name-$size \
> +				$(perl -e "print 'v' x $size;")
> +		done
> +	done
> +	attr_list $file
> +done
> +rm $x $y $z
> +
> +# Set/remove.
> +touch $x
> +attr_set $x $name_in_ibody $(perl -e "print 'i' x 25000;")
> +attr_set $x $name_in_block $(perl -e "print 'b' x 25000;")
> +attr_list $x
> +attr_remove $x $name_in_ibody
> +attr_remove $x $name_in_block
> +rm $x
> +
> +# Set with same value twice.
> +touch $x
> +attr_set $x $name_in_ibody $(perl -e "print 'i' x 60000;")
> +attr_set $x $name_in_ibody $(perl -e "print 'i' x 60000;")
> +attr_list $x
> +rm $x
> +
> +# Repeatedly set an extended attribute with various value sizes.
> +touch $x
> +for size in 0 10 40 80 3000 9000 60 10000 9000 0 8000 3000 10 0 20 10000 5; do
> +	attr_set $x user.1 $(perl -e "print 'v' x $size;")
> +done
> +attr_list $x
> +rm $x
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/ext4/026.out b/tests/ext4/026.out
> new file mode 100644
> index 000000000000..5b94f3e2e4ea
> --- /dev/null
> +++ b/tests/ext4/026.out
> @@ -0,0 +1,29 @@
> +QA output created by 026
> +user.bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb-4096
> +user.bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb-65536
> +user.bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb-8000
> +user.i-4096
> +user.i-65536
> +user.i-8000
> +
> +user.bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb-4096
> +user.bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb-65536
> +user.bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb-8000
> +user.i-4096
> +user.i-65536
> +user.i-8000
> +
> +user.bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb-4096
> +user.bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb-65536
> +user.bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb-8000
> +user.i-4096
> +user.i-65536
> +user.i-8000
> +
> +user.bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
> +user.i
> +
> +user.i
> +
> +user.1
> +
> diff --git a/tests/ext4/group b/tests/ext4/group
> index 664c0591e345..9aed07e271fe 100644
> --- a/tests/ext4/group
> +++ b/tests/ext4/group
> @@ -28,6 +28,7 @@
>  023 auto quick scrub
>  024 auto quick encrypt dangerous
>  025 auto quick fuzzers dangerous 
> +026 auto quick attr
>  271 auto rw quick
>  301 aio auto ioctl rw stress defrag
>  302 aio auto ioctl rw stress defrag
> -- 
> 2.14.0.rc0.284.gd933b75aa4-goog
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
