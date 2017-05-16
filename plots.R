library(ggplot2)
library(ggrepel)


#Time vs. Sampling percent
ggplot(sketch,aes(x=sampled,y=run_time, color=program, linetype=num_reads)) + geom_line() + theme_bw() +
     labs(y="Counting Time (sec)", x="Sample Percent") + coord_cartesian(xlim=c(0,100)) +
     geom_point(data=kmc) + scale_y_log10() +
     geom_text_repel(data=kmc,aes(label=kmc$num_reads))

#Memory vs. Sampling percent
ggplot(sketch,aes(x=sampled,y=max_rss, color=program, linetype=num_reads)) + geom_line() + theme_bw() +
  labs(y="Peak RSS Mem (MB)", x="Sample Percent") + coord_cartesian(xlim=c(0,100)) +
  geom_point(data=kmc) + scale_y_log10() +
  geom_text_repel(data=kmc,aes(label=kmc$num_reads))


#ingroup accuracy
ggplot(sketch,aes(x=sampled,y=avg_abs_diff_in, color=program, linetype=num_reads)) + geom_line() + theme_bw() + 
    labs(y="Avg Abs Log Diff Ingroup", x="Sample Percent") + coord_cartesian(xlim=c(0,100))

#ecoli
ggplot(esketch,aes(x=sampled,y=avg_abs_diff_in, color=program, linetype=num_reads)) + geom_line() + theme_bw() + 
  labs(y="Avg Abs Log Diff Ingroup", x="Sample Percent") + coord_cartesian(xlim=c(0,60))

#outgroup accuracy
ggplot(sketch,aes(x=sampled,y=avg_abs_diff_out, color=program, linetype=num_reads)) + geom_line() + theme_bw() + 
    labs(y="Avg Abs Log Diff Outgroup", x="Sample Percent") +coord_cartesian(xlim=c(0,100))

#ecoli
ggplot(esketch,aes(x=sampled,y=avg_abs_diff_in, color=program, linetype="IN")) +geom_line() +
  geom_line(data=esketch,aes(x=sampled,y=avg_abs_diff_out, color=program, linetype="OUT")) +  theme_bw() + 
  labs(y="Avgerage Absolute Log Difference In/Out Groups", x="Sample Percent of 7M reads") + coord_cartesian(xlim=c(0,60))


#query time
ggplot(r2,aes(x=rmem,y=query_time, color=prog)) + geom_point() + theme_bw() +
  labs(y="Query Time (sec)", x="Peak RSS Mem (KB)") + 
  coord_cartesian(xlim=c(0,7000000),ylim=c(0, 200)) + 
  geom_text_repel(aes(label=prog))

