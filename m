Received: from mx1.redhat.com ([209.132.183.28]:53241 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbfIPGHh (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 16 Sep 2019 02:07:37 -0400
Date: Mon, 16 Sep 2019 14:14:56 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH v2] generic/430: add copy in same file test
Message-ID: <20190916061456.GI7239@dhcp-12-102.nay.redhat.com>
References: <20190904125821.7736-1-yin-jianhong@163.com>
 <20190915055754.GL2622@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190915055754.GL2622@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: "Jianhong.Yin" <yin-jianhong@163.com>, fstests@vger.kernel.org, jiyin@redhat.com
List-ID: <fstests@vger.kernel.org>

On Sun, Sep 15, 2019 at 01:58:01PM +0800, Eryu Guan wrote:
> On Wed, Sep 04, 2019 at 08:58:21PM +0800, Jianhong.Yin wrote:
> > now xfstests has not cover the senario that copy in same file
> > related bug:
> >  copy_file_range return "Invalid argument" when copy in the same file
> >  https://bugzilla.kernel.org/show_bug.cgi?id=202935
> > 
> > step1:
> >  copy whole file to itself, and compare with original file.
> 
> This is explicitly forbidden by commit 96e6e8f4a68d ("vfs: add missing
> checks to copy_file_range").

Yes, you're right. Tested on latest upstream kernel with XFS:

# xfs_io -f -t -c "pwrite -S 0xff 0 1m" -c "copy_range testfile" testfile
wrote 1048576/1048576 bytes at offset 0
1 MiB, 256 ops; 0.0051 sec (195.733 MiB/sec and 50107.6532 ops/sec)
copy_range: Invalid argument

So VFS doesn't allow overlapped copying within same file now. We need to
re-think about this test now.

Thanks,
Zorro

> 
> > step2:
> >  copy whole file to end of itself, and compare the two halves with the original file
> > step3:
> >  recover from original file.
> > 
> > Signed-off-by: Jianhong Yin <yin-jianhong@163.com>
> > ---
> > 
> > this is a base function test, I don't think we should add a new
> > test for it like 553 554, so add it in generic/430
> > what do you think?
> > 
> >  tests/generic/430     | 12 ++++++++++++
> >  tests/generic/430.out |  4 ++++
> >  2 files changed, 16 insertions(+)
> > 
> > diff --git a/tests/generic/430 b/tests/generic/430
> > index 1b11f60d..4ce0ee26 100755
> > --- a/tests/generic/430
> > +++ b/tests/generic/430
> > @@ -6,6 +6,7 @@
> >  #
> >  # Tests vfs_copy_file_range():
> >  #   - Copy a file
> > +#   - Copy in same file
> >  #   - Copy beginning of original to new file
> >  #   - Copy middle of original to a new file
> >  #   - Copy end of original to new file
> > @@ -52,6 +53,17 @@ cmp $testdir/file $testdir/copy
> >  echo "Original md5sums:"
> >  md5sum $testdir/{file,copy} | _filter_test_dir
> >  
> > +fsize=$(stat -c %s $testdir/copy)
> > +echo "Copy in same file"
> > +$XFS_IO_PROG    -c "copy_range -l $fsize $testdir/copy" "$testdir/copy"
> > +cmp $testdir/file $testdir/copy
> > +$XFS_IO_PROG    -c "copy_range -l $fsize -d $fsize $testdir/copy" "$testdir/copy"
> > +cmp -n $fsize $testdir/file $testdir/copy
> > +cmp -i $fsize:0 $testdir/file $testdir/copy
> 
> We should skip '0' from original file and $fsize from the copy, i.e.
> 
> cmp -i 0:$fsize $testdir/file $testdir/copy
> 
> Thanks,
> Eryu
> 
> > +$XFS_IO_PROG -f -c "copy_range $testdir/file" "$testdir/copy"
> > +echo "md5sums after copying in same file and recover:"
> > +md5sum $testdir/{file,copy} | _filter_test_dir
> > +
> >  echo "Copy beginning of original file"
> >  $XFS_IO_PROG -f -c "copy_range -l 1000 $testdir/file" "$testdir/beginning"
> >  cmp -n 1000 $testdir/file $testdir/beginning
> > diff --git a/tests/generic/430.out b/tests/generic/430.out
> > index 4b4ca75d..57584957 100644
> > --- a/tests/generic/430.out
> > +++ b/tests/generic/430.out
> > @@ -3,6 +3,10 @@ Create the original file and then copy
> >  Original md5sums:
> >  e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/file
> >  e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/copy
> > +Copy in same file
> > +md5sums after copying in same file and recover:
> > +e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/file
> > +e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/copy
> >  Copy beginning of original file
> >  md5sums after copying beginning:
> >  e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/file
> > -- 
> > 2.21.0
> > 
