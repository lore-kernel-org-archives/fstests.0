Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C44EB64D9
	for <linux-fstests@archiver.kernel.org>; Fri,  7 Jul 2023 16:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjGGQSj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 Jul 2023 12:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGGQSj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Jul 2023 12:18:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA361FC6
        for <fstests@vger.kernel.org>; Fri,  7 Jul 2023 09:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688746675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BdWaKG04LQqqkTjM3Mp8PNh4WGTNo+zH7Jpbtx3YhJM=;
        b=AgxsrGShfmyWNUmKzD1Ej1H4At0xPmRuvwyGxESSC+oLIdAQag4j/az0tzBBeH5gGTAv5v
        6rP7C9rP9FgwaEfG9+dwK0JVxMYR3c4qBGC8u4LA4s5toiJsR4Tkw2frXEck/yQ+jib50v
        zn5kzlLI7A+meC2/z4FwwfOtMrasB8k=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-pTYJC9aRPxuAQSmBM_jQ_A-1; Fri, 07 Jul 2023 12:17:53 -0400
X-MC-Unique: pTYJC9aRPxuAQSmBM_jQ_A-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1b8b23338a5so22707715ad.3
        for <fstests@vger.kernel.org>; Fri, 07 Jul 2023 09:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688746672; x=1691338672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdWaKG04LQqqkTjM3Mp8PNh4WGTNo+zH7Jpbtx3YhJM=;
        b=YwhJ/nmNMaU+0BJIpBOuPQSfHy9yU2RJ/3uTIfNlO6VuRcupZHbnML+Fj83PkTTz67
         R5ld5bwNUP8y0mADDxuwN0+E8TXcuXkOKuIycxSBAHZ8IjaSxDkBsM2ky/FPCBuHPBTS
         3cRUI3RmHd8ioy0N+/Uc+13Rj7X3lZbRJgizqvOWTi1a/Ocymgo4GPnCMIOoh0ziczAj
         2YIZbrxGjOOjdrqaeR7+fphlRfvBwyKR5OWKfrAdzgkesVT16/kRPpKm6XbozNGVR+Rs
         OqXR9Xl0qVKw4LbuNzMxvMoNgKqKJlKGQg5tufsUzi3V3VIKU28Hl87c3bTQ8sssuW7t
         1d9w==
X-Gm-Message-State: ABy/qLaq41QJYlnli730m6Ekap/4ho3SSLjMxRflaxiEXP4UpzsbD3XK
        +BAJMgzU3WapenU0TW9SSuJccJfiP3TtQi0xMIqr+Og+racplqMyChfjBlE26XKbtVNkNQIHJG/
        yWjahzWxdaKfw3a8iNgx7MsGqZR2SDvU=
X-Received: by 2002:a17:902:d486:b0:1b2:1b22:196 with SMTP id c6-20020a170902d48600b001b21b220196mr6312061plg.48.1688746672585;
        Fri, 07 Jul 2023 09:17:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFpEamQtttPcZzQ9WNnCLE1dc27YOQsS92jvoj9hwK4gzzmSwj+YGdxiFI7FSjtcdnIG9y6cw==
X-Received: by 2002:a17:902:d486:b0:1b2:1b22:196 with SMTP id c6-20020a170902d48600b001b21b220196mr6312028plg.48.1688746672201;
        Fri, 07 Jul 2023 09:17:52 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902b40100b001b8013ed362sm3459611plr.96.2023.07.07.09.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 09:17:51 -0700 (PDT)
Date:   Sat, 8 Jul 2023 00:17:47 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] report: safely update the result.xml file
Message-ID: <20230707161747.efz7azf6jta4e27w@zlang-mailbox>
References: <20230706204232.1577765-1-tytso@mit.edu>
 <20230707150130.GA11442@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707150130.GA11442@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jul 07, 2023 at 08:01:30AM -0700, Darrick J. Wong wrote:
> On Thu, Jul 06, 2023 at 04:42:31PM -0400, Theodore Ts'o wrote:
> > After every single test, we rewrite result.xml from scratch.  This
> > ensures that the XML file is always in a valid, parseable state, even
> > if the check script is killed or the machine crashes in the middle of
> > a test.
> > 
> > If the test is being run in a Cloud VM as a "spot" (Amazon, Azure, or
> > GCE) or "preemptible" (Oracle) instance, it is possible that the VM
> > can be halted whenever the Cloud provider needs the capacity for
> > customers who are willing to pay full price.  ("Spot" instances can be
> > 60% to 90% cheaper --- allowing the frugal kernel developer to get up
> > to 10 times more testing for the same amount of money.  :-)
> > 
> > Since a "spot" VM can get terminated at any time, it is possible for
> > the VM to be terminated immediately after a test has completed and
> > while the result.xml file is in the middle of being written out.  In
> > that case, the result.xml file could partially written, resulting in
> > an invalid result.xml file and lost information about the tests run
> > before the VM was terminated.
> > 
> > To address this race, write the new result.xml file as result.xml.new,
> > and only rename it to result.xml after the XML file is fully written
> > out.
> > 
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > ---
> >  common/report | 19 +++++++++++--------
> >  1 file changed, 11 insertions(+), 8 deletions(-)
> > 
> > diff --git a/common/report b/common/report
> > index 9bfa09ecc..3ad14f94e 100644
> > --- a/common/report
> > +++ b/common/report
> > @@ -109,13 +109,15 @@ _xunit_make_section_report()
> >  	local notrun_count="$4"
> >  	local sect_time="$5"
> >  	local timestamp
> > +	local tmp_fn="$REPORT_DIR/result.xml.new"
> > +	local out_fn="$REPORT_DIR/result.xml"
> >  
> >  	if [ $sect_name == '-no-sections-' ]; then
> >  		sect_name='global'
> >  	fi
> >  	local report=$tmp.report.xunit.$sect_name.xml
> >  	# Header
> > -	echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > $REPORT_DIR/result.xml
> > +	echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > "$tmp_fn"
> 
> Nit: You might want to rm -f $tmp_fn first to reduce the nastiness if
> someone plants a named pipe at that path.
> 
> >  	if [ -n "$test_start_time" ]; then
> >  		timestamp="$(date -Iseconds --date="$test_start_time")"
> >  	else
> > @@ -123,7 +125,7 @@ _xunit_make_section_report()
> >  	fi
> >  
> >  	local fstests_ns="https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git"
> > -	cat >> $REPORT_DIR/result.xml << ENDL
> > +	cat >> "$tmp_fn" << ENDL
> >  <testsuite
> >   xmlns="$fstests_ns"
> >   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
> > @@ -142,19 +144,20 @@ ENDL
> >  	__generate_report_vars
> >  
> >  	# Properties
> > -	echo -e "\t<properties>" >> $REPORT_DIR/result.xml
> > +	echo -e "\t<properties>" >> "$tmp_fn"
> >  	(for key in "${!REPORT_VARS[@]}"; do
> >  		_xunit_add_property "$key" "${REPORT_VARS["$key"]}"
> >  	done;
> >  	for p in "${REPORT_ENV_LIST[@]}"; do
> >  		_xunit_add_property "$p" "${!p}"
> > -	done) | sort >> $REPORT_DIR/result.xml
> > -	echo -e "\t</properties>" >> $REPORT_DIR/result.xml
> > +	done) | sort >> "$tmp_fn"
> > +	echo -e "\t</properties>" >> "$tmp_fn"
> >  	if [ -f $report ]; then
> > -		cat $report >> $REPORT_DIR/result.xml
> > +		cat $report >> "$tmp_fn"
> >  	fi
> > -	echo "</testsuite>" >> $REPORT_DIR/result.xml
> > -	echo "Xunit report: $REPORT_DIR/result.xml"
> > +	echo "</testsuite>" >> "$tmp_fn"
> > +	mv "$tmp_fn" "$out_fn"
> 
> Second nit: Make sure we actually wrote tmp_fn before blowing away the
> old report.
> 
> sync "$tmp_fn" && mv "$tmp_fn" "$out_fn"

I can help to add this when I merge it, if Ted doesn't want to change
more than that.

Just curious, will renameat2 ignore data still in cached? I never did things
likes "sync && mv" before, is there any known issue or it's as expected?

Thanks,
Zorro


> 
> With that fixed,
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> --D
> 
> > +	echo "Xunit report: $out_fn"
> >  }
> >  
> >  _xunit_make_testcase_report()
> > -- 
> > 2.31.0
> > 
> 

