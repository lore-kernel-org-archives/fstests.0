Received: from imap.thunk.org ([74.207.234.97]:33152 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751673AbeEDVPT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 4 May 2018 17:15:19 -0400
Date: Fri, 4 May 2018 17:15:17 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] Use the original install-sh file from SGI
Message-ID: <20180504211517.GL29205@thunk.org>
References: <20180503050728.25779-1-tytso@mit.edu>
 <20180504151232.GD8373@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504151232.GD8373@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, May 04, 2018 at 11:12:32PM +0800, Eryu Guan wrote:
> I think we could follow what xfsprogs does on this, that puts install-sh
> in include dir and copy it from there after it's overwritten by
> libtoolize.
> 
> This looks like a straightforward change, I can fix it on commit if the
> change looks sane to you.

Sounds good to me.   Thanks!!

					- Ted
