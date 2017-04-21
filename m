Received: from imap.thunk.org ([74.207.234.97]:60588 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1035496AbdDUFsa (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 21 Apr 2017 01:48:30 -0400
Date: Fri, 21 Apr 2017 01:48:26 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] gce-xfstests: allow customizing creation of GCE firewall
 rules
Message-ID: <20170421054826.eiybxzharpjseozx@thunk.org>
References: <20170417195645.74168-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170417195645.74168-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 17, 2017 at 12:56:45PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add a new config variable GCE_FIREWALL_RULES which can be overridden in
> ~/.config/gce-xfstests to change or disable creation of extra GCE
> firewall rules like "allow-http".  This will be useful for people who
> want to configure their firewall differently or are not using the
> gce-xfstests web interface.
> 
> Also start creating the firewall rules synchronously and not hiding
> errors.  This will be useful if someone enters incorrect syntax in
> GCE_FIREWALL_RULES, causing creating a firewall rule to fail.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

						- Ted
