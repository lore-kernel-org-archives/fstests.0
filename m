Received: from mx1.redhat.com ([209.132.183.28]:45831 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767AbcF2Mwi (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 29 Jun 2016 08:52:38 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D010A63303
	for <fstests@vger.kernel.org>; Wed, 29 Jun 2016 12:52:37 +0000 (UTC)
Date: Wed, 29 Jun 2016 20:52:36 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] xfstests: Add mkfs input validation tests
Message-ID: <20160629125236.GM23649@eguan.usersys.redhat.com>
References: <1465893068-1615-1-git-send-email-jtulak@redhat.com>
 <1467196693-9724-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467196693-9724-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jan Tulak <jtulak@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 29, 2016 at 12:38:13PM +0200, Jan Tulak wrote:
> mkfs.xfs does not do a very good job of input validation. This test
> is designed to exercise the input validation and test good/bad
> combinations of options being set. It will not pass on an old
> mkfs.xfs binary - it is designed to be the test case for an input
> validation cleanup (merged in spring/summer 2016).
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Jan Tulak <jtulak@redhat.com>
> 
> ---
> 
> I didn't got other feedback than the three small issues fixed bellow, and it is
> passing on current xfsprogs-dev as it should. So I think that it can be merged.

Looks good to me.

> 
> CHANGES:
>   * Change copyright year to 2016
>   * rm || true --> rm -f
>   * Change from space to tab indent
> 
> Cheers,
> Jan
> 
> Signed-off-by: Jan Tulak <jtulak@redhat.com>
> ---
>  tests/xfs/400-input-validation     | 335 +++++++++++++++++++++++++++++++++++++
>  tests/xfs/400-input-validation.out |   2 +

Only one problem with this test seq name. Current Makefile doesn't
support installing such test seq name

  $(INSTALL) -m 755 [0-9]?? $(TARGET_DIR)

Can you please send another patch to fix this?

Thanks,
Eryu
