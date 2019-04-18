Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58041 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729331AbfDRCHR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 Apr 2019 22:07:17 -0400
Date: Wed, 17 Apr 2019 22:07:10 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [xfstests-bld PATCH] test-appliance: add libzstd1 to
 backport-packages-stretch
Message-ID: <20190418020710.GA2881@mit.edu>
References: <20190417223937.31822-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417223937.31822-1-ebiggers@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers@kernel.org>
Cc: Satya Tangirala <satyat@google.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Apr 17, 2019 at 03:39:37PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The btrfs-progs package in stretch-backports recently started depending
> on libzstd1, so add libzstd1 to the backport-packages-stretch file.
> This fixes the following error when building test appliances:
> 
>     dpkg: dependency problems prevent configuration of btrfs-progs:
>      btrfs-progs depends on libzstd1 (>= 1.3.8); however:
>       Package libzstd1 is not installed.
> 
>     dpkg: error processing package btrfs-progs (--install):
>      dependency problems - leaving unconfigured
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

					- Ted
