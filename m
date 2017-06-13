Received: from verein.lst.de ([213.95.11.211]:53646 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752622AbdFMGr3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 13 Jun 2017 02:47:29 -0400
Date: Tue, 13 Jun 2017 08:47:28 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] sample xfstests IMA-appraisal test module (resending)
Message-ID: <20170613064728.GC31372@lst.de>
References: <1497031364-19949-1-git-send-email-zohar@linux.vnet.ibm.com> <1497038143.21594.251.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497038143.21594.251.camel@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>, James Morris <jmorris@namei.org>, linux-fsdevel@vger.kernel.org, linux-ima-devel@lists.sourceforge.net, linux-security-module@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Adding the fstests list..

On Fri, Jun 09, 2017 at 03:55:43PM -0400, Mimi Zohar wrote:
> On systems where IMA-appraisal is configured, the file system properly
> labeled and the system booted with the "ima_tcb ima_appraise_tcb" boot
> command line options, new files created by root will have a file hash
> written out as security.ima.
> 
> This xfstests creates a file and compares the security.ima before and
> after modifying the file.  The results are compared with the "good"
> file.
> 
> (For filesystems that are configured with IMA-appraisal, but aren't
> labeled properly, boot the system with the "ima_appraise=tcb" boot
> command line option as well.)
> 
> Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  tests/generic/440     | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/440.out | 13 ++++++++
>  tests/generic/group   |  1 +
>  3 files changed, 103 insertions(+)
>  create mode 100755 tests/generic/440
>  create mode 100644 tests/generic/440.out
> 
> diff --git a/tests/generic/440 b/tests/generic/440
> new file mode 100755
> index 0000000..8616a48
> --- /dev/null
> +++ b/tests/generic/440
> @@ -0,0 +1,89 @@
> +#! /bin/bash
> +# FS QA Test No. 440
> +#
> +# Tests IMA-appraisal
> +# Derived from 062 tests
> +#
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/attr
> +
> +if [ "$FSTYP" = "btrfs" ]; then
> +. ./common/btrfs
> +elif [ "$FSTYP" = "xfs" ]; then
> +. ./common/xfs
> +fi
> +
> +_cleanup()
> +{
> +        cd /
> +	echo; echo "*** unmount"
> +	_scratch_unmount 2>/dev/null
> +	rm -f $tmp.*
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +getfattr()
> +{
> +    $GETFATTR_PROG --absolute-names -dh $@ 2>&1 | _filter_scratch
> +}
> +
> +setfattr()
> +{
> +    $SETFATTR_PROG $@ 2>&1 | _filter_scratch
> +}
> +
> +_create_test_bed()
> +{
> +	echo "*** create temporary file"
> +	echo "Hello" >  $SCRATCH_MNT/hello.txt
> +}
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +
> +_require_scratch
> +_require_attrs
> +_require_command "$(which timeout)" "timeout"
> +
> +# real QA test starts here
> +_scratch_mkfs > /dev/null 2>&1 || _fail "mkfs failed"
> +_scratch_mount || _fail "mount failed"
> +_create_test_bed
> +
> +xattr="security.ima"
> +testfile="hello.txt"
> +
> +if [ ! -f $SCRATCH_MNT/$testfile ]; then
> +	echo "File $testfile does not exist"
> +	msleep 1
> +fi
> +
> +echo "*** Reading $SCRATCH_MNT"
> +timeout -s KILL 2 cat $SCRATCH_MNT/$testfile > /dev/null
> +if [ $? -ne 0 ]; then
> +	echo "Failed to read $SCRATCH_MNT/$testfile"
> +fi
> +
> +echo "*** initial security.ima hash"
> +getfattr -e hex -n $xattr $SCRATCH_MNT/$testfile
> +
> +echo " World!" >> $SCRATCH_MNT/$testfile
> +
> +echo "*** updated security.ima hash"
> +getfattr -e hex -n $xattr $SCRATCH_MNT/$testfile
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/440.out b/tests/generic/440.out
> new file mode 100644
> index 0000000..a827377
> --- /dev/null
> +++ b/tests/generic/440.out
> @@ -0,0 +1,13 @@
> +QA output created by 440
> +*** create temporary file
> +*** Reading /mnt/scratch
> +*** initial security.ima hash
> +# file: SCRATCH_MNT/hello.txt
> +security.ima=0x040466a045b452102c59d840ec097d59d9467e13a3f34f6494e539ffd32c1bb35f18
> +
> +*** updated security.ima hash
> +# file: SCRATCH_MNT/hello.txt
> +security.ima=0x0404cddd9990ad741e165a6a50990afe969c2233fc8794d027cdbf382f698a62a22f
> +
> +
> +*** unmount
> diff --git a/tests/generic/group b/tests/generic/group
> index 5d3e4dc..c1ecc23 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -442,3 +442,4 @@
>  437 auto quick
>  438 auto
>  439 auto quick punch
> +440 attr
> -- 
> 2.9.3
---end quoted text---
