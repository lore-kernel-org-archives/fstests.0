Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED408C433B4
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Apr 2021 00:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2BB06105A
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Apr 2021 00:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbhDLAko (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 11 Apr 2021 20:40:44 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43241 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235474AbhDLAkn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 11 Apr 2021 20:40:43 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13C0eCRg007876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Apr 2021 20:40:13 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6AA9815C3B0D; Sun, 11 Apr 2021 20:40:12 -0400 (EDT)
Date:   Sun, 11 Apr 2021 20:40:12 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Eryu Guan <guan@eryu.me>, Christian Brauner <brauner@kernel.org>,
        fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v12 2/6] generic/632: add fstests for idmapped mounts
Message-ID: <YHOW7DN51YuYgLPM@mit.edu>
References: <20210328223400.1800301-1-brauner@kernel.org>
 <20210328223400.1800301-3-brauner@kernel.org>
 <YHMH/JRmzg3ETcED@desktop>
 <20210411151249.6y34x7yatqtpcvi6@wittgenstein>
 <20210411151857.wd6gd46u53vlh2xv@wittgenstein>
 <YHMUAL/oD4fB3+R7@desktop>
 <20210411153223.vhcegiklrwoczy55@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210411153223.vhcegiklrwoczy55@wittgenstein>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Apr 11, 2021 at 05:32:23PM +0200, Christian Brauner wrote:
> Ah, ok I didn't know this needed to go in there. I thinke the following
> might be enough. Are you able to simply apply it on top?
> 
> diff --git a/common/rc b/common/rc
> index 351996fc..bd913d13 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2047,6 +2047,16 @@ _require_mount_setattr()
>  # test whether idmapped mounts are supported
>  _require_idmapped_mounts()
>  {
> +       case "$FSTYP" in
> +       xfs)
> +               ;;
> +       ext4)
> +               ;;
> +       *)
> +               _notrun "Filesystem $FSTYP does not support idmapped mounts yet"
> +               ;;
> +       esac
> +

Is there any way we can ask the kernel which file systems support
idmapped mounts?  That way, the tests will do the right thing when run
on older LTS kernels, and if a distribution backports idmapped support
for some file system into their kernel, again, the right thing can
happen automatically.

If you can't do this by checking to see if the file system will
support a particular mount option, or some other run-time test, for
ext4 we can signal this by checking for the existence of a file in
/sys/fs/ext4/features, such as /sys/fs/ext4/features/fast_commit.
(Grep for EXT4_ATTR_FEATURE and ATTR_LIST in fs/ext4/sysfs.c; it
requires adding two lines to advertise a new ext4 feature.)

	 	    	     	       - Ted
