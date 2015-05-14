Return-Path: <eguan@redhat.com>
Date: Thu, 14 May 2015 13:44:50 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs_repair: test for false positive reserved attr name
 use
Message-ID: <20150514054450.GD1140@dhcp-13-216.nay.redhat.com>
References: <555414EA.80301@redhat.com>
 <20150514045546.GC1140@dhcp-13-216.nay.redhat.com>
 <E4DB2C47-54FA-4DAF-84C0-2F585B7510A4@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E4DB2C47-54FA-4DAF-84C0-2F585B7510A4@sandeen.net>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, May 14, 2015 at 12:23:14AM -0500, Eric Sandeen wrote:
> All good advice; sigh, I am rusty!  Thanks, will resend with fixes.
> 
> (Started as using test dev so left some things out; not sure I need a trap if there is nothing to clean up?  Also do we need to require attr on xfs?  Can't remember if we can compile that out, but I guess it's harmless to include it)

I did a "grep _require_attrs tests/xfs/*" and result showed several
tests in xfs require attrs. At least it checks if ATTR_PROG exists :)

And I think we need a trap and cleanup even if there's no obvious things
to clean, some functions use $tmp.xxx internally, a cleanup could remove
all these tmp files too, and trap plays with exit status, so it's still
needed.

Thanks,
Eryu
> 
> Thanks,
> -Eric 
> 
> > On May 13, 2015, at 11:55 PM, Eryu Guan <eguan@redhat.com> wrote:
> > 
> >> On Wed, May 13, 2015 at 10:22:18PM -0500, Eric Sandeen wrote:
> >> xfs_repair compares attr names in the root namespace to
> >> two special/reserved names, "SGI_ACL_FILE" and "SGI_ACL_DEFAULT"
> >> and if the value in them aren't valid acls, flags this as
> >> an inconsistency.
> >> 
> >> However, due to various bugs, xfs_repair may only compare
> >> a smaller portion of the on-disk value; hence either
> >> substrings or superstrings may match, and false-positive
> >> corruption will be detected.  This test checks for those
> >> false positives; i.e. the ACL names created in this test
> >> may cause xfs_repair to "fix" them, but it should not.
> >> 
> >> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> >> ---
> >> 
> >> patch for xfs_repair will be sent shortly
> >> 
> >> diff --git a/tests/xfs/053 b/tests/xfs/053
> >> new file mode 100755
> >> index 0000000..284c014
> >> --- /dev/null
> >> +++ b/tests/xfs/053
> >> @@ -0,0 +1,76 @@
> >> +#! /bin/bash
> >> +# FS QA Test 053
> >> +#
> >> +# Ensure that xfs_repair can properly spot SGI_ACL_FILE
> >> +# and SGI_ACL_DEFAULT in the root attr namespace.
> >> +#
> >> +# Due to bugs here and there, we sometimes matched on partial
> >> +# strings with those names, and threw off xfs_repair.
> >> +#
> >> +#-----------------------------------------------------------------------
> >> +# Copyright (c) 2015 Red Hat, Inc.  All Rights Reserved.
> >> +#
> >> +# This program is free software; you can redistribute it and/or
> >> +# modify it under the terms of the GNU General Public License as
> >> +# published by the Free Software Foundation.
> >> +#
> >> +# This program is distributed in the hope that it would be useful,
> >> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> +# GNU General Public License for more details.
> >> +#
> >> +# You should have received a copy of the GNU General Public License
> >> +# along with this program; if not, write the Free Software Foundation,
> >> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> >> +#-----------------------------------------------------------------------
> >> +#
> >> +
> >> +seq=`basename $0`
> >> +seqres=$RESULT_DIR/$seq
> >> +echo "QA output created by $seq"
> >> +
> >> +here=`pwd`
> >> +tmp=/tmp/$$
> >> +status=1    # failure is the default!
> > 
> > I haven't run the test yet, but I don't see the trap and cleanup
> > function, is that on purpose?
> > 
> >> +
> >> +# get standard environment, filters and checks
> >> +. ./common/rc
> >> +. ./common/filter
> > 
> > . ./common/attr and _require_attrs ?
> > 
> >> +
> >> +# real QA test starts here
> >> +
> >> +_supported_fs xfs
> >> +_supported_os IRIX Linux
> >> +_require_scratch
> >> +
> >> +rm -f $seqres.full
> > 
> > Seems this file is not used and the rm can be omitted.
> > 
> >> +
> >> +_scratch_mount
> > 
> > Should _scratch_mkfs first
> > 
> >> +
> >> +# Create root namespace attr names which are substrings or superstrings
> >> +# of the reserved ACL names, and make sure xfs_repair copes.
> >> +
> >> +# Due to various bugs, either the compared length was shorter
> >> +# than the reserved name (7 chars), so substrings matched, and/or only
> >> +# the reserved name length was compared, so superstrings matched.
> >> +
> >> +rm -f $SCRATCH_MNT/$seq.*
> > 
> > If it's fresh fs, this seems unnecessary.
> > 
> >> +
> >> +# actual reserved names:
> >> +#           SGI_ACL_FILE    SGI_ACL_DEFAULT \
> >> +for NAME in SGI_ACL \
> >> +        SGI_ACL_F        SGI_ACL_D \
> >> +        SGI_ACL_FILE_FOO    SGI_ACL_DEFAULT_FOO; do
> >> +    touch $SCRATCH_MNT/${seq}.${NAME}
> >> +    attr -R -s $NAME -V "Wow, such $NAME" $SCRATCH_MNT/${seq}.${NAME} \
> >> +        | _filter_scratch
> > 
> > $ATTR_PROG
> > 
> > Thanks,
> > Eryu
> > 
> >> +done
> >> +
> >> +# Older repair failed because it sees the above names as matching
> >> +# SGI_ACL_FILE / SGI_ACL_DEFAULT but w/o valid acls on them
> >> +
> >> +# The test harness will catch this (false positive) corruption
> >> +
> >> +# success, all done
> >> +status=0
> >> +exit
> >> diff --git a/tests/xfs/053.out b/tests/xfs/053.out
> >> new file mode 100644
> >> index 0000000..d876555
> >> --- /dev/null
> >> +++ b/tests/xfs/053.out
> >> @@ -0,0 +1,11 @@
> >> +QA output created by 053
> >> +Attribute "SGI_ACL" set to a 17 byte value for SCRATCH_MNT/053.SGI_ACL:
> >> +Wow, such SGI_ACL
> >> +Attribute "SGI_ACL_F" set to a 19 byte value for SCRATCH_MNT/053.SGI_ACL_F:
> >> +Wow, such SGI_ACL_F
> >> +Attribute "SGI_ACL_D" set to a 19 byte value for SCRATCH_MNT/053.SGI_ACL_D:
> >> +Wow, such SGI_ACL_D
> >> +Attribute "SGI_ACL_FILE_FOO" set to a 26 byte value for SCRATCH_MNT/053.SGI_ACL_FILE_FOO:
> >> +Wow, such SGI_ACL_FILE_FOO
> >> +Attribute "SGI_ACL_DEFAULT_FOO" set to a 29 byte value for SCRATCH_MNT/053.SGI_ACL_DEFAULT_FOO:
> >> +Wow, such SGI_ACL_DEFAULT_FOO
> >> diff --git a/tests/xfs/group b/tests/xfs/group
> >> index 58144d2..26dd881 100644
> >> --- a/tests/xfs/group
> >> +++ b/tests/xfs/group
> >> @@ -50,6 +50,7 @@
> >> 050 quota auto quick
> >> 051 auto log metadata
> >> 052 quota db auto quick
> >> +053 acl auto
> >> 054 quota auto quick
> >> 055 dump ioctl remote tape
> >> 056 dump ioctl auto quick
> >> 
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe fstests" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
