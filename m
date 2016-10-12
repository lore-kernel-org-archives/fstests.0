Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:16303 "EHLO
        ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751041AbcJLVXa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 12 Oct 2016 17:23:30 -0400
Date: Thu, 13 Oct 2016 08:16:30 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2 RESEND] posix_acl: Clear SGID bit when setting file
 permissions
Message-ID: <20161012211630.GM23194@dastard>
References: <1474299768-15150-1-git-send-email-jack@suse.cz>
 <20161011231101.GB126173@google.com>
 <20161012071651.GB13896@quack2.suse.cz>
 <20161012173549.GA120419@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161012173549.GA120419@google.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers@google.com>
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@ZenIV.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Oct 12, 2016 at 10:35:49AM -0700, Eric Biggers wrote:
> Cc +fstests@vger.kernel.org
> 
> On Wed, Oct 12, 2016 at 09:16:51AM +0200, Jan Kara wrote:
> > Hi,
> > 
> > On Tue 11-10-16 16:11:01, Eric Biggers wrote:
> > > On Mon, Sep 19, 2016 at 05:42:48PM +0200, Jan Kara wrote:
> > > > When file permissions are modified via chmod(2) and the user is not in
> > > > the owning group or capable of CAP_FSETID, the setgid bit is cleared in
> > > > inode_change_ok().  Setting a POSIX ACL via setxattr(2) sets the file
> > > > permissions as well as the new ACL, but doesn't clear the setgid bit in
> > > > a similar way; this allows to bypass the check in chmod(2).  Fix that.
> > > > 
> > > 
> > > This patch is causing xfstests generic/314 to fail.  This test is supposed to
> > > test "SGID inheritance on subdirectories", and the failure is because subdir2
> > > unexpectedly ends up without a SGID bit.  This happens because the following
> > > commands now result in the SGID bit on the parent directory "$TEST_DIR/$seq-dir"
> > > being cleared rather than set:
> > > 
> > > 	mkdir $TEST_DIR/$seq-dir
> > > 	chown $qa_user:12345 $TEST_DIR/$seq-dir
> > > 	chmod 2775 $TEST_DIR/$seq-dir
> > > 	su $qa_user -c "setfacl -m u:$qa_user:rwx,d:u:$qa_user:rwx $TEST_DIR/$seq-dir"
> > > 
> > > Is this the expected behavior now?
> > 
> > Yes, this is expected behavior - $qa_user is not in group 12345 and thus he
> > could not set sgid bit himself. So once mode is modified by the user (and
> > the setfacl command you presented will touch file mode) sgid bit is expected
> > to be cleared - this is to be consistent with the behavior when:
> > 
> >   chmod 2755 $TEST_DIR/$seq-dir
> > 
> > done by $qa_user would clear the sgid bit as well.
> > 
> > 								Honza
> > -- 
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
> 
> Is this true even though we're talking about a directory, not a regular file?
> 
> From the POSIX man page for chmod (man 3 chmod):
> 
>        If the calling process does not have appropriate privileges, and if the
>        group ID of the file does not match the effective group ID or  one  of
>        the  supplementary  group  IDs  and  if the file is a regular file, bit
>        S_ISGID (set-group-ID on execution) in the file's mode shall be cleared
>        upon successful return from chmod().
> 
> Note the "is a regular file".  Granted, Linux already cleared the SGID bit on
> directories too, so your patch is consistent with that existing behavior.  But
> if "directories too" is really the "correct" behavior, it looks like there need
> to be xfstests updates:
> 
> 	* generic/314, which is supposed to test SGID inheritance, should be
> 	  updated to not depend on any specific SGID clearing behavior.  As-is
> 	  this test is failing.
> 
> 	* generic/375, which is a new test that is supposed to test
> 	  SGID clearing, possibly should test both a regular file and a
> 	  directory.  Right now it only tests a regular file.
> 
> Thoughts on this?

Send patches to fix/update the tests.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
