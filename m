Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46828 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726449AbfEPQ77 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 May 2019 12:59:59 -0400
Date: Thu, 16 May 2019 12:59:21 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] fstests: generic, fsync fuzz tester with fsstress
Message-ID: <20190516165921.GA4023@mit.edu>
References: <20190515150221.16647-1-fdmanana@kernel.org>
 <20190516092848.GA6975@mit.edu>
 <CAL3q7H7q5Xphhax3qPdt1fnjaWrekMgMKzKfDyOLm+bbgsw6Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7q5Xphhax3qPdt1fnjaWrekMgMKzKfDyOLm+bbgsw6Aw@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests <fstests@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>, linux-ext4 <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Thu, May 16, 2019 at 10:54:57AM +0100, Filipe Manana wrote:
> 
> Haven't tried ext4 with 1 process only (instead of 4), but I can try
> to see if it happens without concurrency as well.

How many CPU's and how much memory were you using?  And I assume this
was using KVM/QEMU?  How was it configured?

Thanks,

					- Ted
