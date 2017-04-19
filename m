Received: from mx1.redhat.com ([209.132.183.28]:35036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759084AbdDSCyn (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 18 Apr 2017 22:54:43 -0400
Date: Wed, 19 Apr 2017 10:54:40 +0800
From: Xiong Zhou <xzhou@redhat.com>
Subject: Re: [PATCH v4 4/4] generic: mmap write readonly DAX file
Message-ID: <20170419025440.bedwhf4twz5bk77a@XZHOUW.usersys.redhat.com>
References: <1492008380-29164-1-git-send-email-xzhou@redhat.com>
 <1492413255-11146-1-git-send-email-xzhou@redhat.com>
 <1492413255-11146-5-git-send-email-xzhou@redhat.com>
 <20170418170506.GD25618@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170418170506.GD25618@linux.intel.com>
Sender: fstests-owner@vger.kernel.org
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Xiong Zhou <xzhou@redhat.com>, fstests@vger.kernel.org, dan.j.williams@intel.com, jmoyer@redhat.com, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

On Tue, Apr 18, 2017 at 11:05:06AM -0600, Ross Zwisler wrote:
> On Mon, Apr 17, 2017 at 03:14:15PM +0800, Xiong Zhou wrote:
> > Regression case that one can write to read-only
> > file in a DAX mountpoint.
> > 
> > Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> 
> Yep, this test works fine in my setup.  It fails for me, as expected, with
> v4.10.0, and passes as expected with v4.10.3. I've added a few small comments
> below, but with those addressed you can add:
> 
> Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> 
> > +int
> > +main(int argc, char **argv)
> > +{
> > +	int fd, pfd, ret;
> > +	char *buf;
> > +	/* gcc -O2 will optimize foo's storage, preventing
> > +	 * reproduce this issue.
> > +	 * foo is never actually used after fault in value stored.
> > +	 */
> > +	volatile char foo __attribute__((__unused__));
> > +	int pagesize = getpagesize();
> > +
> > +	if (argc < 2) {
> > +		printf("Usage: %s <file> <pmem file>\n", basename(argv[0]));
> > +		exit(0);
> > +	}
> > +
> > +	fd = open(argv[1], O_RDONLY|O_DIRECT);
> > +	if (fd < 0)
> > +		err_exit("open");
> > +
> > +	pfd = open(argv[2], O_RDONLY);
> > +	if (pfd < 0)
> > +		err_exit("pmem open");
> > +
> > +	buf = mmap(NULL, pagesize, PROT_READ, MAP_SHARED, pfd, 0);
> > +	if (buf == MAP_FAILED)
> > +		err_exit("mmap");
> > +
> > +	/*
> > +	 * Read from the DAX mmap to populate the first page in the
> > +	 * address_space with a read-only mapping.
> > +	 */
> > +	foo = *buf;
> > +
> > +	/*
> > +	 * Now write to the DAX mmap.  This *should* fail, but if the bug is
> > +	 * present in __get_user_pages_fast(), it will succeed.
> > +	 */
> > +	ret = read(fd, buf, pagesize);
> > +	if (ret != pagesize)
> > +		err_exit("read");
> > +
> > +	ret = msync(buf, pagesize, MS_SYNC);
> > +	if (ret != 0)
> > +		err_exit("msync");
> > +
> > +	ret = munmap(buf, pagesize);
> > +	if (ret < 0)
> > +		err_exit("munmap");
> > +
> > +	ret = close(fd);
> > +	if (ret < 0)
> > +		err_exit("clsoe fd");
> 			  close
> 
> > diff --git a/tests/generic/424 b/tests/generic/424
> > new file mode 100755
> > index 0000000..f73e08a
> > --- /dev/null
> > +++ b/tests/generic/424
> > @@ -0,0 +1,92 @@
> > +#! /bin/bash
> > +# FS QA Test 424
> > +#
> > +# This is a regression test for kernel commit
> > +#  ef947b2 x86, mm: fix gup_pte_range() vs DAX mappings
> > +# created by Jeffrey Moyer <jmoyer@redhat.com>
> > +#
> > +# This is reproducible only when testing on pmem device
> > +# which is configured in "memory mode", not in "raw mode".
> > +#
> > +#-----------------------------------------------------------------------
> > +# Copyright (c) 2017 Red Hat.  All Rights Reserved.
> > +#
> > +# This program is free software; you can redistribute it and/or
> > +# modify it under the terms of the GNU General Public License as
> > +# published by the Free Software Foundation.
> > +#
> > +# This program is distributed in the hope that it would be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> > +#
> > +# You should have received a copy of the GNU General Public License
> > +# along with this program; if not, write the Free Software Foundation,
> > +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > +#-----------------------------------------------------------------------
> > +#
> > +
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -rf $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# Modify as appropriate.
> > +_supported_fs generic
> > +_supported_os Linux
> > +_require_scratch_dax
> > +_require_test_program "t_mmap_write_ro"
> > +_require_user
> 
> Could also maybe benefit from "_require_test", which makes sure your TEST_DEV

Yes! Good catch!

> is a block device?  I don't think you get this explicitly tested with
> _test_cycle_mount?
> 
> I think you're also missing a:
> 	_require_pmem_key_value $SCRATCH_DEV "mode" "memory"

No. I don't wanna limit this test running only on "memory mode" pmem
devices because it CAN run on "raw mode" devices. More testing will
not hurt, :)
