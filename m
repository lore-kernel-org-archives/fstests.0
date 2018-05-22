Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:53538 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751419AbeEVFOV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 May 2018 01:14:21 -0400
Date: Tue, 22 May 2018 15:12:10 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] cifs: Add README.cifs
Message-ID: <20180522051210.GS10363@dastard>
References: <20180521225247.17811-1-lsahlber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521225247.17811-1-lsahlber@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Ronnie Sahlberg <lsahlber@redhat.com>
Cc: fstests <fstests@vger.kernel.org>, Steve French <smfrench@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Tue, May 22, 2018 at 08:52:47AM +1000, Ronnie Sahlberg wrote:
> This is a patch to provide quickstart instructions for how to use xfstest
> for CIFS.
> 
> Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
> ---
>  README.cifs | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 README.cifs
> 
> diff --git a/README.cifs b/README.cifs
> new file mode 100644
> index 00000000..92efd24d
> --- /dev/null
> +++ b/README.cifs
> @@ -0,0 +1,61 @@
> +This describes how to get up and running using xfstests for the CIFS filesystem.
> +
> +There are additional information on testing cifs with xfstest on the samba
> +wiki : https://wiki.samba.org/index.php/Xfstesting-cifs
> +
> +
> +
> +Quick Setup
> +===========
> +
> +local.config
> +------------
> +Xfstests needs two cifs shares. One normal share and one scratch share.
> +The data on the scratch share will be destroyed so set this up as a dedicate
> +share on your server and do not store anything important in it.
> +
> +The first thing we need is to set up some stanzas for different smb dialects.
> +These dialects can then be selected using the -s command line option making
> +it a convenient way to pick a specific version of smb to test.
> +
> +Download the example configuration and name it local.config:
> +
> +  wget https://wiki.samba.org/images/9/99/Xfstests.local.config.txt \
> +      -O local.config

We actually have example config files in configs/ already. So
why not just add a "example.cifs.config" file in there?


> +Update local.config and change SERVER, SHARE, SCRATCH, USERNAME, PASSWORD to
> +match your shares.
> +
> +Create the /mnt/test and /mnt/share mountpoints.
> +
> +
> +Exclusion files
> +---------------
> +Some tests do not yet work for SMB and some tests take very long so we may want
> +to skip them. In CIFS we do this using exclusion files.
> +
> +Download the exclusion files for smb3 and for very slow tests:
> +
> +  wget https://wiki.samba.org/images/9/99/Xfstests.exclude.very-slow.txt \
> +      -O tests/cifs/exclude.very-slow
> +  wget https://wiki.samba.org/images/d/d9/Xfstests.exclude.known-broken-smb3.txt
> +      -O tests/cifs/exclude.known-broken-smb3

I'd prefer we don't deep link to files like this - it's too easy for
them to get broken (e.g. by a wiki upgrade and re-org). Can you
refer to obtaining them from the "Using xfstests with CIFS" page
linked above instead?

Also, it would be better to refer to tests that are not compatible
with CIFS to call them "incompatible" instead of "broken". Broken
implies there's something wrong with the tests, and that's not the
case here. The first impression of "oh, there's lots of broken
tests in xfstests" is not correct, nor is it a good one.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
