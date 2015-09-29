Received: from mx1.redhat.com ([209.132.183.28]:37657 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756015AbbI2PKo (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 29 Sep 2015 11:10:44 -0400
Date: Tue, 29 Sep 2015 23:10:40 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH V3] generic _require_dm_target() helper, use in
 generic/085
Message-ID: <20150929151040.GK30949@dhcp-13-216.nay.redhat.com>
References: <5609B358.9030601@redhat.com>
 <5609BE8B.5010707@sandeen.net>
 <560A9980.8040509@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <560A9980.8040509@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>
Cc: Eric Sandeen <sandeen@sandeen.net>, fstests <fstests@vger.kernel.org>, Angelo Dureghello <angelo.dureghello@nomovok.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 29, 2015 at 09:00:32AM -0500, Eric Sandeen wrote:
> generic/085 was failing on a machine w/o devicemapper kernel
> support because it requires the linear target, but didn't
> explicitly test for it.
> 
> I could have cut & pasted _require_dm_linear(), but chose
> to go the route of a generic helper, _require_dm_target $FOO,
> because some day someone will need the zero target, the error
> target, or who knows.
> 
> Add the helper, use it in test generic/085, and convert
> _require_dm_flakey, _require_dm_snapshot, and
> _dmerror_required with this new helper.
> 
> Reported-by: Angelo Dureghello <angelo.dureghello@nomovok.com>
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Looks good to me, thanks Eric!

Reviewed-by: Eryu Guan <eguan@redhat.com>
