Received: from imap.thunk.org ([74.207.234.97]:34830 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751479AbdFIDHs (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 8 Jun 2017 23:07:48 -0400
Date: Thu, 8 Jun 2017 23:07:46 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 2/2] xfstests-bld: misc: remove encrypt-smoketest
Message-ID: <20170609030746.c2wfwdnr32gx4bax@thunk.org>
References: <20170608214627.136906-1-ebiggers3@gmail.com>
 <20170608214627.136906-2-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170608214627.136906-2-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 08, 2017 at 02:46:27PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The encrypt-smoketest script isn't really useful anymore now that
> xfstests has an "encrypt" group of tests, which can be run in all
> configurations using a command like 'kvm-xfstests -g encrypt'.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

					- Ted
