Received: from mx1.redhat.com ([209.132.183.28]:45039 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751509AbcBKJPz (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 11 Feb 2016 04:15:55 -0500
Date: Thu, 11 Feb 2016 17:15:51 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: Does _need_to_be_root deserve to live?
Message-ID: <20160211091551.GA11419@eguan.usersys.redhat.com>
References: <20160211035746.GA16082@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160211035746.GA16082@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 10, 2016 at 10:57:46PM -0500, Theodore Ts'o wrote:
> There appear to be a number of tests that need to mount and unmount
> scratch or su to $qa_user that don't call the helper _need_to_be_root.
> 
> Also, sicne the check script calls _check_filesystems between every
> single test, which requires unmounting and remounting the test and/or
> scratch file systems, does the _need_to_be_root check make any sense
> at all?
> 
> And if doesn't make any sense, is it worth it to submitting a patch
> that just removes all mention of _need_to_be_root from the tests and
> common/rc?

I think it's safe to remove all _need_to_be_root calls, because there's
already a user-id check in "check"

346 if [ `id -u` -ne 0 ]
347 then
348     echo "check: QA must be run as root"
349     exit 1
350 fi

Thanks,
Eryu
