Received: from mx1.redhat.com ([209.132.183.28]:39410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751534AbdKMEMI (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 12 Nov 2017 23:12:08 -0500
Date: Mon, 13 Nov 2017 12:12:06 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [ANNOUNCE] fstests: master branch updated to 1e24e5173efa
Message-ID: <20171113041206.GB17339@eguan.usersys.redhat.com>
References: <5a080ffd.958d620a.7689f.68d1@mx.google.com>
 <CAOQ4uxgveiWmid80JCQaozT4eYQiMyJjYTQkmVYFnk0cB9iuyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgveiWmid80JCQaozT4eYQiMyJjYTQkmVYFnk0cB9iuyg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>, Jeff Layton <jlayton@poochiereds.net>, "J. Bruce Fields" <bfields@fieldses.org>
List-ID: <fstests@vger.kernel.org>

On Sun, Nov 12, 2017 at 11:50:55AM +0200, Amir Goldstein wrote:
> On Sun, Nov 12, 2017 at 11:09 AM, Eryu Guan <guaneryu@gmail.com> wrote:
> > Hi all,
> >
> > The master branch of the xfstests repository at:
> >
> >         git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> >
> > have just been updated. This update contains a new open_by_handle test from
> > Amir and the remaining bits from Darrick to prepare for v4.15 merge window.
> > Other commits are random bug fixes.
> >
> > New failures I've noticed in this update:
> > - generic/467 fails on NFSv3 and NFSv4.0 (passes on NFSv4.[12] though)
> 
> Can you please share the failure errors on NFSv3.

Sure.

NFSv3:
 test_file_handles TEST_DIR/467-dir -rp
+open_by_handle(/mnt/testarea/test) returned 116 incorrectly on a linked dir!
 ...
 test_file_handles TEST_DIR/467-dir.renamed -rp
+open_by_handle(/mnt/testarea/test) returned 116 incorrectly on a linked dir!
 test_file_handles TEST_DIR/467-dir.new -rp
+open_by_handle(/mnt/testarea/test) returned 116 incorrectly on a linked dir!

NFSv4.0:
 test_file_handles TEST_DIR/467-dir -rp
+open_by_handle(/mnt/testarea/test/467-dir/file000000) returned 116 incorrectly on a linked file!
...
 test_file_handles TEST_DIR/467-dir -dkr
 test_file_handles TEST_DIR/467-dir -lr
+open_by_handle(/mnt/testarea/test/467-dir/file000000) returned 116 incorrectly on a linked file!
...
 test_file_handles TEST_DIR/467-dir -ur
+open_by_handle(/mnt/testarea/test/467-dir/file000000) returned 116 incorrectly on a linked file!
...
 test_file_handles TEST_DIR/467-dir -mr
+open_by_handle(/mnt/testarea/test/467-dir/file000000) returned 116 incorrectly on a linked file!
...
 test_file_handles TEST_DIR/467-dir.renamed -rp
+open_by_handle(/mnt/testarea/test/467-dir.renamed/file000000) returned 116 incorrectly on a linked file!
...
 test_file_handles TEST_DIR/467-dir.new -rp
+open_by_handle(/mnt/testarea/test/467-dir.new/file000000) returned 116 incorrectly on a linked file!

Thanks,
Eryu

> 
> Test is also failing on tmpfs, which was acknowledged by nfsd maintainers
> as a tmpfs bug or at least very undesired behavior for exported tmpfs.
> 
> Thanks,
> Amir.
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
