Return-Path: <fstests-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:65275 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753252AbaIOJMh (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 15 Sep 2014 05:12:37 -0400
Message-ID: <5416AD82.5070206@nod.at>
Date: Mon, 15 Sep 2014 11:12:34 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
Subject: Re: [PATCH] Add UBIFS support
References: <1410772280-9771-1-git-send-email-richard@nod.at>
In-Reply-To: <1410772280-9771-1-git-send-email-richard@nod.at>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-mtd@lists.infradead.org
List-ID: <fstests@vger.kernel.org>

Am 15.09.2014 11:11, schrieb Richard Weinberger:
> UBIFS needs some extra care, the device node is of type character and
> it has no fsck tool.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  README        |  1 +
>  check         |  2 ++
>  common/config |  4 ++--
>  common/rc     | 18 ++++++++++++++++++
>  4 files changed, 23 insertions(+), 2 deletions(-)

To avoid confusion, this patch is for xfstests. :-)

Thanks,
//richard
