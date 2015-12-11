Received: from sandeen.net ([63.231.237.45]:54552 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752757AbbLKCob (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 10 Dec 2015 21:44:31 -0500
Subject: Re: [PATCH 1/2] xfs/133: test project quota name beginning with
 digits
References: <1449681026-4469-1-git-send-email-zlang@redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <566A388E.8000907@sandeen.net>
Date: Thu, 10 Dec 2015 20:44:30 -0600
MIME-Version: 1.0
In-Reply-To: <1449681026-4469-1-git-send-email-zlang@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: eguan@redhat.com, sandeen@redhat.com
List-ID: <fstests@vger.kernel.org>



On 12/9/15 11:10 AM, Zorro Lang wrote:
> There's a known bug of xfsprogs, when a project name beinning with
> digits, it can't be found by run xfs_quota 'quota -p -v ...' command.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>

My other error was something spurious, sorry - can't hit it again,
I forgot repair was pointing off into a build tree, not proper upstream
xfs_repair on the system.  Seems fine now.

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

> ---
>  tests/xfs/133     | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/133.out |   1 +
>  tests/xfs/group   |   1 +
>  3 files changed, 103 insertions(+)
>  create mode 100755 tests/xfs/133
>  create mode 100644 tests/xfs/133.out
> 
> diff --git a/tests/xfs/133 b/tests/xfs/133
> new file mode 100755
> index 0000000..330221f
> --- /dev/null
> +++ b/tests/xfs/133
> @@ -0,0 +1,101 @@
> +#! /bin/bash
> +# FS QA Test 133
> +#
> +# Test xfs_quota when project names beginning with digits.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2015 Red Hat Inc.  All Rights Reserved.
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
> +qa_user=""
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
> +. ./common/quota
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs xfs
> +_supported_os Linux
> +_require_scratch
> +_require_xfs_quota
> +
> +_scratch_mkfs_xfs >/dev/null 2>&1
> +
> +do_project_test()
> +{
> +	local qa_project=123456-project
> +	local dir=$SCRATCH_MNT/project
> +
> +	mkdir $dir 2>/dev/null
> +
> +	#project quota files
> +	cat >$tmp.projects <<EOF
> +10:$dir
> +EOF
> +
> +	cat >$tmp.projid <<EOF
> +$qa_project:10
> +EOF
> +
> +	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +		-c "project -s $qa_project" $SCRATCH_MNT >>$seqres.full 2>&1
> +	[ $? -ne 0 ] && _fail "Initalize project=$qa_project Failed"
> +
> +	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +		-c "limit -p bsoft=100m bhard=200m $qa_project" $SCRATCH_MNT >>$seqres.full 2>&1
> +	[ $? -ne 0 ] && _fail "Create limit for project=$qa_project Failed"
> +
> +	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +		-c "quota -p -v $qa_project" $SCRATCH_MNT 2>>$seqres.full | grep -qw $qa_project
> +	[ $? -ne 0 ] && _fail "Query project=$qa_project Failed"
> +
> +	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> +		-c "report -p" $SCRATCH_MNT 2>>$seqres.full | grep -qw $qa_project
> +	[ $? -ne 0 ] && _fail "Report project=$qa_project Failed"
> +
> +	return 0
> +}
> +
> +# Test project
> +_qmount_option "uquota,pquota"
> +_qmount
> +_require_prjquota $SCRATCH_DEV
> +do_project_test
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/133.out b/tests/xfs/133.out
> new file mode 100644
> index 0000000..189cb69
> --- /dev/null
> +++ b/tests/xfs/133.out
> @@ -0,0 +1 @@
> +QA output created by 133
> diff --git a/tests/xfs/group b/tests/xfs/group
> index 9884329..bae09de 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -130,6 +130,7 @@
>  130 fuzzers
>  131 auto quick clone
>  132 auto quick clone
> +133 auto quick quota
>  134 quota auto quick
>  136 attr2
>  142 dmapi
> 
