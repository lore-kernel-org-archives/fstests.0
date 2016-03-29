Received: from mx1.redhat.com ([209.132.183.28]:51164 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778AbcC2M3V (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 29 Mar 2016 08:29:21 -0400
Date: Tue, 29 Mar 2016 20:29:19 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: replace chattr with $CHATTR_PROG
Message-ID: <20160329122919.GG19986@eguan.usersys.redhat.com>
References: <1458930998-22548-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1458930998-22548-1-git-send-email-jbacik@fb.com>
Sender: fstests-owner@vger.kernel.org
To: Josef Bacik <jbacik@fb.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 25, 2016 at 02:36:38PM -0400, Josef Bacik wrote:
> We have a wrapper around chattr to make sure people don't do the wrong thing on
> their boxes, so we need to be able to specify CHATTR_PROG and have it actually
> work, so replace all chattr calls with $CHATTR_PROG.

Looks good to me overall, but it doesn't apply because of this commit

26ae452 btrfs/059: add a filter for btrfs compression property

Thanks,
Eryu
