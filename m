Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80265C433FE
	for <linux-fstests@archiver.kernel.org>; Thu, 13 Oct 2022 16:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJMQ2r (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 13 Oct 2022 12:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJMQ2q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 13 Oct 2022 12:28:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAED10F8A2
        for <fstests@vger.kernel.org>; Thu, 13 Oct 2022 09:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665678524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6wwpBq6SHFYDdcz7t5eB9kJ+xjI/zbGfcUPrGluEm80=;
        b=OfrYfyNfsCskRgDPBeHMYclUGARDpzbVsl4jxw8TnRSVKZDTsXoHhCfIqnGZbbeDHj6/0i
        c2ZgtlQvJmOF4SOOcxeasrLhg0LTP/7mOARCw9DT8XZUsFdR3L0iczmeCN4DwfvpdIUTfY
        9HXjkT46m6jraM52ruaLtfHPwJhNXvA=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-561-aLe2-88OPyCbIKpwlMjrqg-1; Thu, 13 Oct 2022 12:28:42 -0400
X-MC-Unique: aLe2-88OPyCbIKpwlMjrqg-1
Received: by mail-pf1-f198.google.com with SMTP id t7-20020a62ea07000000b005619a832f68so1460759pfh.11
        for <fstests@vger.kernel.org>; Thu, 13 Oct 2022 09:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wwpBq6SHFYDdcz7t5eB9kJ+xjI/zbGfcUPrGluEm80=;
        b=NE5+kAa7QgjwK6rcyEkHsCGh5T7bvVlanMaWbInS7qNtYgrWB485C7kLWkDLk1e19e
         naP/tOFQbCOruEajVKF7HfeSbFFRALeS6+0DzQsAIq+182ryudV7jINoWInW5qzdRBmD
         YPe8vQWKOILeEgm9rXou5kj9uFtDu0k2mecqJw+vBJB+Kow1Z7QUc7GiqeyD67mcotlz
         lZoNB5vaZUVX78EjBji5DaaOwCDJwI2PxL3w0YivHLHkXR7gx0bTV2jyKMikE2f8OCT1
         YeCIbw11chJZRWVDlGqT6W7cZk2d/sGg3yXTXNFrKXF7S++8RDaa/H0Dj7NodqoiXaAN
         yBcA==
X-Gm-Message-State: ACrzQf1kbyJ2jIc/uLaTrnIf52raED/BuvjzJ4oGtPd25jhqkz2xEv31
        HHqk3CYWSSeG5o4cXxjbaLM2AUvUq2yZMLAu/co/mk44tls9Ofl/cryh3ecu0Ly6ZzVAy4GAscZ
        QFL8kIq8NYciZGXCuCA==
X-Received: by 2002:a17:90b:4c4f:b0:20d:4f5d:6b7c with SMTP id np15-20020a17090b4c4f00b0020d4f5d6b7cmr12268446pjb.77.1665678521352;
        Thu, 13 Oct 2022 09:28:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6lo5XEoJ7ijPYunxIx8X5OviVMD0xL6rDoNVdhPiB392mL9bLHPt7mYtyKtzK7FTMgsEyLqQ==
X-Received: by 2002:a17:90b:4c4f:b0:20d:4f5d:6b7c with SMTP id np15-20020a17090b4c4f00b0020d4f5d6b7cmr12268423pjb.77.1665678520984;
        Thu, 13 Oct 2022 09:28:40 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902e95000b0017b264a2d4asm90101pll.44.2022.10.13.09.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 09:28:40 -0700 (PDT)
Date:   Fri, 14 Oct 2022 00:28:26 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/5] populate: export the metadump description name
Message-ID: <20221013162826.hfs75s33giqmfu4t@zlang-mailbox>
References: <166553912229.422450.15473762183660906876.stgit@magnolia>
 <166553912788.422450.6797363004980943410.stgit@magnolia>
 <20221013145515.2vx3xy6hnf37777o@zlang-mailbox>
 <Y0g0u5byHQK/aOEz@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0g0u5byHQK/aOEz@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Oct 13, 2022 at 08:54:35AM -0700, Darrick J. Wong wrote:
> On Thu, Oct 13, 2022 at 10:55:15PM +0800, Zorro Lang wrote:
> > On Tue, Oct 11, 2022 at 06:45:27PM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > Not sure why this hasn't been broken all along, but we should be
> > > exporting this variable so that it shows up in subshells....
> > 
> > May I ask where's the subshell which uses $POPULATE_METADUMP?
> 
> _scratch_xfs_fuzz_metadata does this:
> 
> 	echo "${fields}" | while read field; do
> 		echo "${verbs}" | while read fuzzverb; do
> 			__scratch_xfs_fuzz_mdrestore
> 				_xfs_mdrestore "${POPULATE_METADUMP}"
> 
> The (nested) echo piped to while starts subshells.

I'm not so familar with this part, so I didn't a simple test[1], and looks like
the PARAM can be seen, even it's not exported. Do I misunderstand something?

Thanks,
Zorro

[1]
$ echo "$list"
a
b
cc
$ PARAM="This's a test"
$ echo "$list"|while read c1;do echo "$list"|while read c2;do echo $PARAM;done; done
This's a test
This's a test
This's a test
This's a test
This's a test
This's a test
This's a test
This's a test
This's a test

> 
> > > 
> > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > ---
> > >  common/populate |    6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > 
> > > diff --git a/common/populate b/common/populate
> > > index cfdaf766f0..b501c2fe45 100644
> > > --- a/common/populate
> > > +++ b/common/populate
> > > @@ -868,9 +868,9 @@ _scratch_populate_cached() {
> > >  	local meta_tag="$(echo "${meta_descr}" | md5sum - | cut -d ' ' -f 1)"
> > >  	local metadump_stem="${TEST_DIR}/__populate.${FSTYP}.${meta_tag}"
> > >  
> > > -	# These variables are shared outside this function
> > > -	POPULATE_METADUMP="${metadump_stem}.metadump"
> > > -	POPULATE_METADUMP_DESCR="${metadump_stem}.txt"
> > > +	# This variable is shared outside this function
> > > +	export POPULATE_METADUMP="${metadump_stem}.metadump"
> > > +	local POPULATE_METADUMP_DESCR="${metadump_stem}.txt"
> > 
> > If the POPULATE_METADUMP_DESCR is not shared outside anymore, how about change
> > it to lower-case?
> 
> Ok.
> 
> --D
> 
> > >  
> > >  	# Don't keep metadata images cached for more 48 hours...
> > >  	rm -rf "$(find "${POPULATE_METADUMP}" -mtime +2 2>/dev/null)"
> > > 
> > 
> 

