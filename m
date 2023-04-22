Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449BEC77B61
	for <linux-fstests@archiver.kernel.org>; Sat, 22 Apr 2023 01:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjDVBqA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 21 Apr 2023 21:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDVBp7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 21 Apr 2023 21:45:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974A735BB
        for <fstests@vger.kernel.org>; Fri, 21 Apr 2023 18:45:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3240165333
        for <fstests@vger.kernel.org>; Sat, 22 Apr 2023 01:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82857C433D2;
        Sat, 22 Apr 2023 01:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682127957;
        bh=32qv2lF0yDxT8f+14YAQaUiTduAHr+W9+rwBP2cqL+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CTIfUNHuqtIJZB8W65D9h9Te8XvR5OpWPY1Jk2DVLivDjz2wCEEMaD7eEqYkDJnNo
         CxZGykIwKr0v8qecnvAGWzjlOAGq/ci5Wpuec2cdSUKf0HalTJMv0cRcW6hRY3R41t
         DCq3EQupi3AA3u6M62cHeQyHFA242IvD40TZ8yhqYj6VMQqMHHLpHo75nouETjVtFK
         Fsa4IfGEnKuCA/gnHWzGsFjzBIJypI8XkQhbBr48fwf4mHYDqkfMeVhSjbCE8voibJ
         Uf/C3eoNrEvVShHRFH/lbypZw7F2es6vl5Ost5dHgJeQOJPsAszevlBybWN9UAO8J8
         PhJVrTzw8Rw/g==
Date:   Fri, 21 Apr 2023 18:45:56 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] test-appliance: edit out xmlns from the result.xml
 file
Message-ID: <20230422014556.GR360895@frogsfrogsfrogs>
References: <20230420160837.1083228-1-tytso@mit.edu>
 <20230420160837.1083228-2-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420160837.1083228-2-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 20, 2023 at 12:08:36PM -0400, Theodore Ts'o wrote:
> Commit b76a6cdb40b5 ("report: derive an xml schema for the xunit
> report") in fstests upstream adds an xmlns attribute to the xunit
> <testcase/> tag.  Unfortunately, this breaks the junitparser.py Python
> package, since it uses lxml Python package, and by adding an xmlns
> specifier, junitxml.py would need to know the schema and map that to
> namespace tag.
> 
> So edit it out of the xml file using sed, which relies on the fact
> that fstests will add the xmlns file on a single line.  The "right"
> way would be to use an XSLT processor, but that would bloat the test
> appliance significantly.  So we'll just cheat for now while we discuss
> with fstests upstream whether adding the xmlns attribute is really
> worth the pain and incompatibility that it causes.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  test-appliance/files/root/runtests.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/test-appliance/files/root/runtests.sh b/test-appliance/files/root/runtests.sh
> index 9b32d287..c4ddb739 100755
> --- a/test-appliance/files/root/runtests.sh
> +++ b/test-appliance/files/root/runtests.sh
> @@ -23,6 +23,7 @@ function copy_xunit_results()
>  
>      if test -f "$RESULT"
>      then
> +	sed -i.orig -e 's/xmlns=\".*\"//' "$RESULT"

FWIW I wouldn't mind commenting out the xmlns bits in common/report.

Some XML parsers have this annoying quirk that as soon as anyone
attaches a namespace to the document, every query against that document
has to reference the given namespace explicitly.

Though really, the *frustrating* thing is that in order to enable
automatic validation via the schema document, one has to embed the
xsi:schemaLocation attribute, which forces you to put in a namespace.
Then un-namespaced queries fail, and yay XML. :?

Thoughts?

--D

>  	if test -f "$RESULTS"
>  	then
>  	    merge_xunit "$RESULTS" "$RESULT"
> -- 
> 2.31.0
> 
