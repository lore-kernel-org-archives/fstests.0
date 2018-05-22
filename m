Received: from mail-pl0-f68.google.com ([209.85.160.68]:38533 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751601AbeEVCge (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 May 2018 22:36:34 -0400
Received: by mail-pl0-f68.google.com with SMTP id c11-v6so9940550plr.5
        for <fstests@vger.kernel.org>; Mon, 21 May 2018 19:36:34 -0700 (PDT)
Date: Tue, 22 May 2018 10:36:29 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] cifs: Add README.cifs
Message-ID: <20180522023629.GP29080@desktop.hz.ali.com>
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

Thanks for the documentation! But I think we could simply add a pointer
to above wiki link in the "Running tests" section in README file, as the
wiki page contains all the specific information for running fstests on
CIFS (especially the config template link, the excluded test lists),
which, IMHO, should be maintained on the wiki not fstests.

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
> +
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

BTW, this link gives me a 404 error, so the same link in the wiki page.

Thanks,
Eryu

> +      -O tests/cifs/exclude.very-slow
> +  wget https://wiki.samba.org/images/d/d9/Xfstests.exclude.known-broken-smb3.txt
> +      -O tests/cifs/exclude.known-broken-smb3
> +
> +
> +Running full set of tests
> +=========================
> +With some luck you should be ready to run your first xfstest now.
> +
> +When runnig the "full" set of tests there are multiple tests that are
> +known to fail. Reasons can be that they just don't map well to cifs,
> +we are missing features in cifs or there are bugs that needs to be fixed.
> +
> +For regression testing is useful to run all the tests that are known to work.
> +We can acheive this per protocol version using exclude files and filter
> +out the known broken tests.
> +
> +SMB3
> +----
> +
> +    sudo ./check -s smb3 -E tests/cifs/exclude.known-broken-smb3 \
> +        -E tests/cifs/exclude.very-slow
> -- 
> 2.13.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
