Received: from mail-pf1-f193.google.com ([209.85.210.193]:45394 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfFPNXD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 16 Jun 2019 09:23:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so4159459pfq.12
        for <fstests@vger.kernel.org>; Sun, 16 Jun 2019 06:23:03 -0700 (PDT)
Date: Sun, 16 Jun 2019 21:22:59 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH RESEND] report: gracefully handle XML report creation
 when no tests are run
Message-ID: <20190616132259.GB15846@desktop>
References: <20190609210431.26373-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190609210431.26373-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Jun 09, 2019 at 05:04:31PM -0400, Theodore Ts'o wrote:
> If no tests are run (because they have all been excluded) then make
> sure we insert a valid timestamp into the XML file, and avoid printing
> an error message when reading a non-existent test summary scratch
> file.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
> 
> I sent this a while back, and didn't get any comments, so I'm resending.  PTAL.

Sorry, I totally missed it.. applied now, thanks!

Eryu

> 
>  common/report | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/common/report b/common/report
> index fb00b402..6cac71fc 100644
> --- a/common/report
> +++ b/common/report
> @@ -59,6 +59,9 @@ _xunit_make_section_report()
>  	local report=$tmp.report.xunit.$sect_name.xml
>  	# Header
>  	echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > $REPORT_DIR/result.xml
> +	if [ -z "$date_time" ]; then
> +		date_time=$(date +"%F %T")
> +	fi
>  	local dtime=`echo $date_time| tr  " " 'T'`
>  	local stats="failures=\"$n_bad\" skipped=\"$n_notrun\" tests=\"$n_total\" time=\"$sect_time\""
>  	local hw_info="hostname=\"$HOST\" timestamp=\"$dtime\" "
> @@ -70,7 +73,9 @@ _xunit_make_section_report()
>  		_xunit_add_property "$p"
>  	done
>  	echo -e "\t</properties>" >> $REPORT_DIR/result.xml
> -	cat $tmp.report.xunit.$sect_name.xml >> $REPORT_DIR/result.xml
> +	if [ -f $report ]; then
> +		cat $report >> $REPORT_DIR/result.xml
> +	fi
>  	echo "</testsuite>" >> $REPORT_DIR/result.xml
>  	echo "Xunit report: $REPORT_DIR/result.xml"
>  }
> -- 
> 2.22.0
> 
