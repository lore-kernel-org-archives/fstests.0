Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41901 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726023AbfFRBuv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Jun 2019 21:50:51 -0400
Date: Mon, 17 Jun 2019 21:50:34 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [xfstests-bld PATCH] kernel-configs: add CONFIG_PCI to 4.19
 configs
Message-ID: <20190618015034.GA9033@mit.edu>
References: <20190618000721.138057-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618000721.138057-1-ebiggers@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers@kernel.org>
Cc: Satya Tangirala <satyat@google.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jun 17, 2019 at 05:07:21PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> On v5.0+, CONFIG_PCI is default 'n', so it must be explicitly selected;
> otherwise the kvm-xfstests VM doesn't boot.  It's expected that the 4.19
> configs work on later kernels too (up until whatever becomes the next
> LTS release), so add CONFIG_PCI=y to them.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied, thanks.

					- Ted
