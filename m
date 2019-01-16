Received: from mail-pf1-f194.google.com ([209.85.210.194]:44358 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfAPIMT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Jan 2019 03:12:19 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so2679042pfh.11
        for <fstests@vger.kernel.org>; Wed, 16 Jan 2019 00:12:19 -0800 (PST)
Date: Wed, 16 Jan 2019 16:12:12 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] check: force hostname to be unique
Message-ID: <20190116081212.GI2713@desktop>
References: <20190111215420.9676-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111215420.9676-1-mcgrof@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jan 11, 2019 at 01:54:20PM -0800, Luis Chamberlain wrote:
> If you use a hostname which is part of the output of
> standard tools you end up with failures with fstests
> due to differences in output against the golden output.
> 
> The failures are false positives due to the hostname.
> For instance if you hostname is 'xfs' _dump_filter_main()
> will substitute the initiial 'xfs' with HOSTNAME as part
> of your logs, and will fail the output will fail against
> the golden output on say all xfsdump / xfsrestores tests.
> 
> The hostname must be a unique string, not used as part
> of the output from any tool used when capturing output.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

IMHO, a better fix would be improving the regexp in _dump_filter_main to
match hostname more precisely. I did the following update and it seemed
to work fine, I tested with '-g dump' and all tests passed (some tests
_notrun due to missing tape device).

--- a/common/dump
+++ b/common/dump
@@ -826,7 +826,8 @@ _dump_filter_main()
       -e "s#$__XFSDUMP_PROG#xfsdump#"                  \
       -e "s#$XFSRESTORE_PROG#xfsrestore#"              \
       -e "s#$XFSINVUTIL_PROG#xfsinvutil#"              \
-      -e "s/`hostname`/HOSTNAME/"                      \
+      -e "s/`hostname`:/HOSTNAME:/"                    \
+      -e "s/: `hostname`/: HOSTNAME/"                  \
       -e "s#$SCRATCH_DEV#SCRATCH_DEV#"                 \
       -e "s#$SCRATCH_RAWDEV#SCRATCH_DEV#"              \
       -e "s#$dumptape#TAPE_DEV#"                       \

It's based on the fact that there're basically two patterns that contain
'HOSTNAME':

xfsrestore: hostname: HOSTNAME
xfsdump: level 0 dump of HOSTNAME:SCRATCH_MNT

Thanks,
Eryu
