Date: Thu, 4 Aug 2016 12:24:48 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] xfs: test attr_list_by_handle cursor iteration
Message-ID: <20160804042448.GR27776@eguan.usersys.redhat.com>
References: <20160802235251.GB8586@birch.djwong.org>
 <20160803225150.GC25565@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160803225150.GC25565@birch.djwong.org>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: david@fromorbit.com, linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, xfs@oss.sgi.com, Christoph Hellwig <hch@infradead.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 03, 2016 at 03:51:50PM -0700, Darrick J. Wong wrote:
> Apparently the XFS attr_list_by_handle ioctl has never actually copied
> the cursor contents back to user space, which means that iteration has
> never worked.  Add a test case for this and see
> "xfs: in _attrlist_by_handle, copy the cursor back to userspace".
> 
> v2: Use BULKSTAT_SINGLE for less confusion, fix build errors on RHEL6.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  .gitignore                            |    1 
>  src/Makefile                          |    3 -
>  src/attr-list-by-handle-cursor-test.c |  185 +++++++++++++++++++++++++++++++++
>  tests/xfs/700                         |   64 +++++++++++
>  tests/xfs/700.out                     |    5 +
>  tests/xfs/group                       |    1 
>  6 files changed, 258 insertions(+), 1 deletion(-)
>  create mode 100644 src/attr-list-by-handle-cursor-test.c
>  create mode 100755 tests/xfs/700
>  create mode 100644 tests/xfs/700.out
> 

[snip]

> +
> +	read_handle_xattrs(&handle, false);
> +	read_handle_xattrs(&handle, true);

I have to replace false/true with 0/1 to build it on RHEL6. I can fix it
at commit time if there's no other major updates.

Thanks,
Eryu
