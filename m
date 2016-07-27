Received: from mx1.redhat.com ([209.132.183.28]:56324 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214AbcG0Oa6 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 27 Jul 2016 10:30:58 -0400
Date: Wed, 27 Jul 2016 22:30:55 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/294: fix _filter_mknod quoting
Message-ID: <20160727143055.GY27776@eguan.usersys.redhat.com>
References: <efc1c8a69bb7d09412342841e340b51a709dee63.1469565411.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efc1c8a69bb7d09412342841e340b51a709dee63.1469565411.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: Omar Sandoval <osandov@osandov.com>
Cc: fstests@vger.kernel.org, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

On Tue, Jul 26, 2016 at 01:39:26PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Coreutils 8.4 uses a back tick instead of a single quote when quoting a
> file name. That means that _filter_mknod doesn't properly filter the
> error message from mknod.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

This has been fixed by Jan Kara in latest fstests update.

[9b06a9f] generic/294: Filter backquotes from mknod error output

Thanks for the follow up!

Eryu
