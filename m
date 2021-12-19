Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE91C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Dec 2021 16:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbhLSQEi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 19 Dec 2021 11:04:38 -0500
Received: from out20-1.mail.aliyun.com ([115.124.20.1]:52581 "EHLO
        out20-1.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbhLSQEh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 19 Dec 2021 11:04:37 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.882746|0.8991504;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_system_inform|0.348111-0.00277093-0.649118;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.MJfwuH1_1639929875;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.MJfwuH1_1639929875)
          by smtp.aliyun-inc.com(10.147.42.253);
          Mon, 20 Dec 2021 00:04:36 +0800
Date:   Mon, 20 Dec 2021 00:04:35 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3 00/17] generic: add some mmap CoW tests
Message-ID: <Yb9YE0FesQ2i6iHd@desktop>
References: <20211214081914.2478122-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214081914.2478122-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Dec 14, 2021 at 04:18:57PM +0800, Shiyang Ruan wrote:
> Changes since v1:
>   - Introduce _require_scratch_delalloc() to check if supports delay allocation
>   - Remove useless _require_odirect and _require_cp_reflink in some cases
> 
> This series is to add missing mmap CoW tests in some sets of testcases:
> Set 1. CoW on shared blocks which are interleaving reflinked by two files.
>   - P1:            add mmap test
> Set 2. CoW a range covers shared blocks and multiple kind of unshared blocks of
>    the destination file.
>   - P2 ~ P4, P6:   add mmap test
> Set 3. CoW a range covers shared blocks and multiple kind of unshared blocks of
>    the source file.
>   - P12, P13:      add missing buffered-io and direct-io test for mixed blocks
>   - P8 ~ P11, P14: add mmap test
> Set 4. races tests
>   - P15: race between reflink and mmap reading
>   - P16: race between mmap writing to and reflink source file
>   - P17: race between mmap writing to and reflink target file

Looks good to me overall, thanks!. But it's a large patchset, I'd like
wait for another week for feedbacks, and will merge it next week if
there's no further comments

Thanks,
Eryu

> 
> Shiyang Ruan (17):
>   generic: add mmap CoW test for ranges of two shared files
>   generic: add mmap CoW test for regular&destination extents
>   generic: add mmap CoW test for unwritten&destination extents
>   generic: add mmap CoW test for holes&destination extents
>   common/rc: Introduce _require_scratch_delalloc()
>   generic: add mmap CoW test for delalloc&destination extents
>   generic: add mmap CoW test for mixed&destination extents
>   generic: add mmap CoW test for regular&source extents
>   generic: add mmap CoW test for unwritten&source extents
>   generic: add mmap CoW test for holes&source extents
>   generic: add mmap CoW test for delalloc&source extents
>   generic: add buffered-io CoW test for mixed&source extents
>   generic: add direct-io CoW test for mixed&source extents
>   generic: add mmap CoW test for mixed&source extents
>   generic: add race test between reflink and mmap read
>   generic: add race test that mmap write to source of reflink
>   generic: add race test that mmap write to target of reflink
> 
>  common/rc             | 13 ++++++++
>  common/reflink        | 62 +++++++++++++++++++++++++++++++++++++
>  tests/generic/194     |  1 +
>  tests/generic/195     |  1 +
>  tests/generic/199     |  1 +
>  tests/generic/200     |  1 +
>  tests/generic/293     |  1 +
>  tests/generic/295     |  1 +
>  tests/generic/540     |  1 +
>  tests/generic/541     |  1 +
>  tests/generic/542     |  1 +
>  tests/generic/543     |  1 +
>  tests/generic/900     | 69 +++++++++++++++++++++++++++++++++++++++++
>  tests/generic/900.out | 14 +++++++++
>  tests/generic/901     | 59 +++++++++++++++++++++++++++++++++++
>  tests/generic/901.out | 12 ++++++++
>  tests/generic/902     | 59 +++++++++++++++++++++++++++++++++++
>  tests/generic/902.out | 12 ++++++++
>  tests/generic/903     | 59 +++++++++++++++++++++++++++++++++++
>  tests/generic/903.out | 12 ++++++++
>  tests/generic/904     | 62 +++++++++++++++++++++++++++++++++++++
>  tests/generic/904.out | 12 ++++++++
>  tests/generic/905     | 67 ++++++++++++++++++++++++++++++++++++++++
>  tests/generic/905.out | 12 ++++++++
>  tests/generic/906     | 60 ++++++++++++++++++++++++++++++++++++
>  tests/generic/906.out | 12 ++++++++
>  tests/generic/907     | 62 +++++++++++++++++++++++++++++++++++++
>  tests/generic/907.out | 12 ++++++++
>  tests/generic/908     | 62 +++++++++++++++++++++++++++++++++++++
>  tests/generic/908.out | 12 ++++++++
>  tests/generic/909     | 65 ++++++++++++++++++++++++++++++++++++++
>  tests/generic/909.out | 12 ++++++++
>  tests/generic/910     | 65 ++++++++++++++++++++++++++++++++++++++
>  tests/generic/910.out | 12 ++++++++
>  tests/generic/911     | 66 +++++++++++++++++++++++++++++++++++++++
>  tests/generic/911.out | 12 ++++++++
>  tests/generic/912     | 66 +++++++++++++++++++++++++++++++++++++++
>  tests/generic/912.out | 12 ++++++++
>  tests/generic/913     | 72 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/913.out |  5 +++
>  tests/generic/914     | 64 ++++++++++++++++++++++++++++++++++++++
>  tests/generic/914.out |  4 +++
>  tests/generic/915     | 64 ++++++++++++++++++++++++++++++++++++++
>  tests/generic/915.out |  4 +++
>  tests/xfs/172         | 12 +-------
>  tests/xfs/223         |  1 +
>  tests/xfs/224         |  1 +
>  tests/xfs/228         |  1 +
>  tests/xfs/230         |  1 +
>  tests/xfs/257         |  1 +
>  tests/xfs/258         |  1 +
>  51 files changed, 1284 insertions(+), 11 deletions(-)
>  create mode 100755 tests/generic/900
>  create mode 100644 tests/generic/900.out
>  create mode 100755 tests/generic/901
>  create mode 100644 tests/generic/901.out
>  create mode 100755 tests/generic/902
>  create mode 100644 tests/generic/902.out
>  create mode 100755 tests/generic/903
>  create mode 100644 tests/generic/903.out
>  create mode 100755 tests/generic/904
>  create mode 100644 tests/generic/904.out
>  create mode 100755 tests/generic/905
>  create mode 100644 tests/generic/905.out
>  create mode 100755 tests/generic/906
>  create mode 100644 tests/generic/906.out
>  create mode 100755 tests/generic/907
>  create mode 100644 tests/generic/907.out
>  create mode 100755 tests/generic/908
>  create mode 100644 tests/generic/908.out
>  create mode 100755 tests/generic/909
>  create mode 100644 tests/generic/909.out
>  create mode 100755 tests/generic/910
>  create mode 100644 tests/generic/910.out
>  create mode 100755 tests/generic/911
>  create mode 100644 tests/generic/911.out
>  create mode 100755 tests/generic/912
>  create mode 100644 tests/generic/912.out
>  create mode 100755 tests/generic/913
>  create mode 100644 tests/generic/913.out
>  create mode 100755 tests/generic/914
>  create mode 100644 tests/generic/914.out
>  create mode 100755 tests/generic/915
>  create mode 100644 tests/generic/915.out
> 
> -- 
> 2.34.1
> 
> 
