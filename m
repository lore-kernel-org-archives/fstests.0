Received: from mx1.redhat.com ([209.132.183.28]:46342 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932AbcGUKpP (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 21 Jul 2016 06:45:15 -0400
Date: Thu, 21 Jul 2016 18:45:13 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] generic/235: Fix false failures for some quota formats
Message-ID: <20160721104513.GE27776@eguan.usersys.redhat.com>
References: <1469091306-8559-1-git-send-email-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1469091306-8559-1-git-send-email-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 21, 2016 at 10:55:06AM +0200, Jan Kara wrote:
> Different quota format may print additional information in repquota(8)
> output after standard quota information is printed. If format does
> support this additional printouts, repquota(8) will separate possible
> output by two empty lines even if format handler doesn't actually
> printout anything (which is currently always the case for queries test
> generic/235 does). If format doesn't support additional printouts, these
> two empty lines are not present in the output. This inconsistency causes
> false failures for some quota formats.
> 
> Fix the problem by filtering out empty lines out of repquota(8) output.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  tests/generic/235     | 9 +++++++--
>  tests/generic/235.out | 8 --------
>  2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/generic/235 b/tests/generic/235
> index 59456b67c092..d42054efee91 100755
> --- a/tests/generic/235
> +++ b/tests/generic/235
> @@ -46,6 +46,11 @@ _require_scratch
>  _require_quota
>  _require_user
>  
> +_repquota()
> +{
> +	repquota -u -g $SCRATCH_MNT  | grep -v -E '^root|^$' | _filter_scratch
> +}

Usually we name local functions without the leading "_", which is for
common helpers from common/rc etc. Do you mind if I rename it to
"do_repquota"?

Thanks,
Eryu
