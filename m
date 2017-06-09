Received: from imap.thunk.org ([74.207.234.97]:34528 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751393AbdFIASW (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 8 Jun 2017 20:18:22 -0400
Date: Thu, 8 Jun 2017 20:18:18 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v3 0/3] xfstests-bld: update recommended kernel configs
Message-ID: <20170609001818.fwxzw57mki4ulp3p@thunk.org>
References: <20170601233631.131510-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170601233631.131510-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 01, 2017 at 04:36:28PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> This patchset halves the length of the recommended configs for
> kvm-xfstests and gce-xfstests by trimming unnecessary features, while
> also enabling some extra debugging options.  It also makes the configs
> be more consistent with each other and match LTS kernel versions.
> 
> Changed since v2:
> 	- update all the configs, not just latest x86_64 one
> 	- leave CONFIG_HW_RANDOM_VIRTIO enabled
> 
> Eric Biggers (3):
>   kernel-configs: remove configs for non-LTS versions
>   kernel-configs: improve recommended x86_64 configs
>   kernel-configs: sync i386 configs with x86_64 ones

I've applied these three patches, thanks!

						- Ted
