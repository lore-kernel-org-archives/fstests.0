Received: from mx1.redhat.com ([209.132.183.28]:58328 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825AbcGSEHk (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 19 Jul 2016 00:07:40 -0400
Date: Tue, 19 Jul 2016 12:07:38 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/235: Use CSV format for repquota output
Message-ID: <20160719040738.GK27776@eguan.usersys.redhat.com>
References: <1468843224-8940-1-git-send-email-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1468843224-8940-1-git-send-email-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jul 18, 2016 at 02:00:24PM +0200, Jan Kara wrote:
> Different quota format may print additional information in repquota(8)
> output after standard quota information is printed and this information
> is separated by two empty lines. For quota formats that don't support
> printing any additional information these lines are not present in the
> output which causes false failures of the test. Switch the test to use
> repquota(8) CSV output format which does not have these formatting
> issues and in general should be more stable.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

This breaks tests on distributions with older version of repquota (e.g.
RHEL6 and RHEL7) where there's no "-O" support, and test failed because
of "invalid option -- 'O'".

Thanks,
Eryu
