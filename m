Received: from mx1.redhat.com ([209.132.183.28]:60786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753953AbcLLJIy (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 12 Dec 2016 04:08:54 -0500
Date: Mon, 12 Dec 2016 17:08:51 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v3] overlay: test unstable inode number
Message-ID: <20161212090851.GW29149@eguan.usersys.redhat.com>
References: <1481532306-26938-1-git-send-email-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481532306-26938-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Dec 12, 2016 at 10:45:06AM +0200, Amir Goldstein wrote:
> Introduce a new test to demonstrate a known issue with overlayfs:
> - stat file A shows inode number X
> - modify A to trigger copy up
> - stat file A shows inode number Y != X
> 
> Also test if d_ino of readdir entries changes after copy up.
> 
> There is a POC patch by Miklos Szeredi that fixes this issue.
> 
> Not dealing with hardlinks here, because there is more to test
> then stable inode number.
> Hardlinks will get a test of their own.

Thanks! I added the missing SOB line, and added "copyup" group too.

Eryu
